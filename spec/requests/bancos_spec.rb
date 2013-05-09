#encoding: utf-8

require 'spec_helper'

describe "Bancos" do
  before do
    @user = Factory(:user)
    integration_sign_in(@user)
    @etiqueta = "Banco Galicia"
  end

  it "link de acceso" do
    visit home_path
    response.should have_selector("a", :href => bancos_path, :content => "Bancos")
    click_link "Bancos"
    response.should render_template('bancos/index')
  end

  describe "Asociación con empresa" do
    before do
      @empresa1 = Empresa.create!(:detalle => "TAESA")
      @empresa2 = Empresa.create!(:detalle => "Chantaco")
      @empresa3 = Empresa.create!(:detalle => "SuperFito")
      @empresas = [@empresa1, @empresa2, @empresa3]
      visit new_banco_path
    end

    it "debe haber la misma cantidad de checkbox como empresas" do
      response.should have_selector("input", :type => "checkbox", :count => @empresas.length)
    end

    it "debe tener los nombres correspondientes" do
      response.should have_selector("label", :content => "#{@empresa1[:detalle]}")
      response.should have_selector("label", :content => "#{@empresa2[:detalle]}")
      response.should have_selector("label", :content => "#{@empresa3[:detalle]}")
    end

    it "debe tener el identificador correspondiente" do
      @empresas.each do |empresa|
        response.should have_selector("input#empresa_#{empresa.id}")
      end
    end

    it "deben listarse solo las empresas activas" do
      @empresa2.anular
      @empresa2.save!
      @empresa2.reload
      visit new_banco_path
      response.should have_selector("label", :content => "#{@empresa1[:detalle]}")
      response.should_not have_selector("label", :content => "#{@empresa2[:detalle]}")
      response.should have_selector("label", :content => "#{@empresa3[:detalle]}")
    end

    it "alta de banco sin detalle" do
      lambda do
        visit new_banco_path
        fill_in :banco_detalle, :with => ""
        click_button
        response.should render_template('bancos/new')
        response.should have_selector("div#error_explanation")
      end.should_not change(Banco, :count)
    end

    it "alta de banco sin empresas" do
      lambda do
        visit new_banco_path
        fill_in :banco_detalle, :with => @etiqueta
        click_button
        response.should render_template('bancos/show')
        response.should have_selector("p", :content => @etiqueta)
      end.should change(Banco, :count).by(1)
    end

    describe "comprobación de la asociación" do
      it "alta de banco con empresas" do
        lambda do
          visit new_banco_path
          fill_in :banco_detalle, :with => @etiqueta
          check @empresa1.detalle
          check @empresa3.detalle
          click_button
          response.should render_template('bancos/show')
          response.should have_selector("p", :content => @etiqueta)
        end.should change(Banco, :count).by(1)
      end

      it "Dar de alta una cuenta representada por un saldo" do
        lambda do
          visit new_banco_path
          fill_in :banco_detalle, :with => @etiqueta
          check @empresa1.detalle
          check @empresa3.detalle
          click_button
        end.should change(SaldoBancario, :count).by(2)
      end


    end
  end

  describe "vista edición" do
    before do
      @banco = Banco.create!(:detalle => @etiqueta)
      @empresa1 = Empresa.create!(:detalle => "TAESA")
      @empresa2 = Empresa.create!(:detalle => "Chantaco")
      @empresa3 = Empresa.create!(:detalle => "SuperFito")
      @empresas = [@empresa1, @empresa2, @empresa3]
    end

    it "debe haber la misma cantidad de checkbox como empresas" do
      visit edit_banco_path(@banco)
      response.should have_selector("input", :type => "checkbox", :count => @empresas.length)
    end

    it "debe tener los nombres correspondientes" do
      visit edit_banco_path(@banco)
      response.should have_selector("label", :content => "#{@empresa1[:detalle]}")
      response.should have_selector("label", :content => "#{@empresa2[:detalle]}")
      response.should have_selector("label", :content => "#{@empresa3[:detalle]}")
    end

    it "debe tener el identificador correspondiente" do
      visit edit_banco_path(@banco)
      @empresas.each do |empresa|
        response.should have_selector("input#empresa_#{empresa.id}")
      end
    end

    it "editación de banco sin detalle" do
      lambda do
        visit edit_banco_path(@banco)
        fill_in :banco_detalle, :with => ""
        click_button
        response.should render_template('bancos/edit')
        response.should have_selector("div#error_explanation")
      end.should_not change(Banco, :count)
    end

    it "deben listarse solo las empresas activas" do
      @empresa2.anular
      @empresa2.save!
      @empresa2.reload
      visit edit_banco_path(@banco)
      response.should have_selector("label", :content => "#{@empresa1[:detalle]}")
      response.should_not have_selector("label", :content => "#{@empresa2[:detalle]}")
      response.should have_selector("label", :content => "#{@empresa3[:detalle]}")
    end

    it "deben listarse solo las empresas activas no asignadas" do
      @empresa2.anular
      @empresa2.save!
      @empresa2.reload
      @banco.saldos_bancario.create!(:empresa_id => @empresa3.id, :user_id => @user, :valor => 4)
      visit edit_banco_path(@banco)
      response.should have_selector("label", :content => "#{@empresa1[:detalle]}")
      response.should_not have_selector("label", :content => "#{@empresa2[:detalle]}")
      response.should_not have_selector("input#empresa_#{@empresa3.id}")
    end

    it "Dar de alta un un saldo bancario" do
      lambda do
        visit edit_banco_path(@banco)
        check @empresa1.detalle
        check @empresa3.detalle
        click_button
      end.should change(SaldoBancario, :count).by(2)
    end

    it "debe estar asociado con las empresas seleccionadas" do
      visit new_banco_path
      fill_in :banco_detalle, :with => "Banco Galicia"
      check @empresa1.detalle
      check @empresa3.detalle
      click_button
      @banco = assigns(:banco)
      visit edit_banco_path(@banco)
      response.should have_selector("th", :content => "Empresas activas")
      response.should have_selector("td", :content => "#{@empresa1[:detalle]}")
      response.should have_selector("td", :content => "#{@empresa3[:detalle]}")
    end

    it "debe mostrar los links de deshabilitar las empresas" do
      @banco = Banco.create!(:detalle => @etiqueta)
      @sb = @banco.saldos_bancario.create!(:empresa_id => @empresa1.id, :user_id => @user, :valor => 4)
      visit edit_banco_path(@banco)
      response.should have_selector("a", :href => deshabilitar_saldo_bancario_path(@sb.id), :content => "Deshabilitar")
      click_link "Deshabilitar"
      response.should render_template('bancos/edit')
    end

    # it "se deben haber desasociado todas las empresas" do
    #   @banco = Banco.create!(:detalle => "Banco Galicia")
    #   @banco.empresas = [@empresa1, @empresa3]
    #   visit edit_banco_path(@banco)
    #   uncheck @empresa1.detalle
    #   uncheck @empresa3.detalle
    #   click_button
    #   visit edit_banco_path(@banco)
    #   @empresas.each do |empresa|
    #     field_with_id("empresa_#{empresa.id}").should_not be_checked
    #   end
    # end

  end

  describe "vista detalle" do
    it "debe mostrarse el detalle del banco" do
      @banco = Banco.create!(:detalle => @etiqueta)
      visit banco_path(@banco)
      response.should have_selector("p", :content => "#{@banco[:detalle]}")
    end

    it "debe mostrar solo las empresas asociadas" do
      @empresa1 = Empresa.create!(:detalle => "TAESA")
      @empresa2 = Empresa.create!(:detalle => "Chantaco")
      @empresa3 = Empresa.create!(:detalle => "SuperFito")
      @empresas = [@empresa1, @empresa2, @empresa3]
      @empresa4 = Empresa.create!(:detalle => "GonzaEmpresa")
      @banco = Banco.create!(:detalle => @etiqueta)
      @empresas.each { |empresa|
        @banco.saldos_bancario.create!(:empresa_id => empresa.id, :user_id => @user, :valor => 4)
      }
      visit banco_path(@banco)
      response.should have_selector("ul") do |n|
        n.should have_selector("li", :content => "#{@empresa1[:detalle]}")
        n.should have_selector("li", :content => "#{@empresa2[:detalle]}")
        n.should have_selector("li", :content => "#{@empresa3[:detalle]}")
        n.should_not have_selector("li", :content => "#{@empresa4[:detalle]}")
      end
    end

    it "no debe mostrar ninguna empresa, si no esta asociado" do
      @empresa1 = Empresa.create!(:detalle => "TAESA")
      @empresa2 = Empresa.create!(:detalle => "Chantaco")
      @empresa3 = Empresa.create!(:detalle => "SuperFito")
      @empresas = [@empresa1, @empresa2, @empresa3]
      @empresa4 = Empresa.create!(:detalle => "GonzaEmpresa")
      @banco = Banco.create!(:detalle => @etiqueta)
      visit banco_path(@banco)
      response.should have_selector("ul") do |n|
        n.should_not have_selector("li", :content => "#{@empresa1[:detalle]}")
        n.should_not have_selector("li", :content => "#{@empresa2[:detalle]}")
        n.should_not have_selector("li", :content => "#{@empresa3[:detalle]}")
        n.should_not have_selector("li", :content => "#{@empresa4[:detalle]}")
      end
    end

  end
end
