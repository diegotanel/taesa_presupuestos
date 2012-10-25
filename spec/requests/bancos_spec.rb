#encoding: utf-8

require 'spec_helper'

describe "Bancos" do
  before do
    @user = Factory(:user)
    integration_sign_in(@user)
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

    it "debe haber tres checkbox" do
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

    it "alta de banco sin empresas" do
      lambda do
        visit new_banco_path
        fill_in :banco_detalle, :with => "Banco Galicia"
        click_button
        response.should render_template('bancos/show')
      end.should change(Banco, :count).by(1)
    end

    it "alta de banco con empresas" do
      lambda do
        visit new_banco_path
        fill_in :banco_detalle, :with => "Banco Galicia"
        check @empresa1.detalle
        check @empresa3.detalle
        click_button
        response.should render_template('bancos/show')
      end.should change(Banco, :count).by(1)
    end

    describe "comprobación de la asociación" do
      it "no debe estar asociado con ninguna empresa" do
        visit new_banco_path
        fill_in :banco_detalle, :with => "Banco Galicia"
        click_button
        @banco = assigns(:banco)
        visit edit_banco_path(@banco)
        @empresas.each do |empresa|
          field_with_id("empresa_#{empresa.id}").should_not be_checked
        end
      end

      it "debe estar asociado con las empresas seleccionadas" do
        visit new_banco_path
        fill_in :banco_detalle, :with => "Banco Galicia"
        check @empresa1.detalle
        check @empresa3.detalle
        click_button
        @banco = assigns(:banco)
        visit edit_banco_path(@banco)
        field_with_id("empresa_#{@empresa1.id}").should be_checked
        field_with_id("empresa_#{@empresa2.id}").should_not be_checked
        field_with_id("empresa_#{@empresa3.id}").should be_checked
      end

      it "se deben haber desasociado todas las empresas" do
        @banco = Banco.create!(:detalle => "Banco Galicia")
        @banco.empresas = [@empresa1, @empresa3]
        visit edit_banco_path(@banco)
        uncheck @empresa1.detalle
        uncheck @empresa3.detalle
        click_button
        visit edit_banco_path(@banco)
        @empresas.each do |empresa|
          field_with_id("empresa_#{empresa.id}").should_not be_checked
        end
      end
    end
  end
end
