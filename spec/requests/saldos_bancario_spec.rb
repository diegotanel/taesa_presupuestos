#encoding: utf-8

require 'spec_helper'

describe "SaldosBancarios" do
  describe "como usuario" do
    before do
      @user = Factory(:user)
      @fecha = "25/09/2012 23:06"
      @saldo = Factory(:saldo_bancario, :user => @user, :updated_at => @fecha)
    end

    describe "formulario edición" do
      before do
        integration_sign_in(@user)
        visit edit_saldo_bancario_path(@saldo)
      end

      it "link de acceso" do
        visit home_path
        response.should have_selector("a", :href => edit_saldo_bancario_path(@saldo), :content => "Saldos bancario")
        click_link "Saldos bancario"
        response.should render_template('saldos_bancario/edit')
      end

      it "verificar si el formulario contiene los campos correspondientes" do
        response.should render_template('saldos_bancario/edit')
        response.should have_selector("input#saldo_bancario_valor")
        response.should have_selector("label", :content => "Saldo en pesos")
        response.should have_selector("input", :type => "submit")
      end

      it "debe mostrarse los datos de la cotización actual" do
        response.should have_selector("td", :content => "Último saldo:")
        response.should have_selector("td", :content => "13,56")
        response.should have_selector("td", :content => "Fecha:")
        response.should have_selector("td", :content => @fecha)
        response.should have_selector("td", :content => "Usuario:")
        response.should have_selector("td", :content => "Michael Hartl")
      end

      it "link al home del sitio" do
        response.should have_selector("a", :href => home_path, :content => "Página de inicio")
        click_link "Página de inicio"
        response.should render_template('home')
      end
    end

    describe "actualización del saldo" do

      before do
        @secondUser = Factory(:user, :name => "Bob", :email => "another@example.com")
        integration_sign_in(@secondUser)
        visit edit_saldo_bancario_path(@saldo)
        fechaActualizacion = Time.zone.parse("13/05/2011 23:45")
        Time.stub!(:now).and_return(fechaActualizacion)
      end

      describe "exitoso" do
        before do
          fill_in :saldo_bancario_valor, :with => "4,65"
          click_button
        end

        it "el formulario debe mostrar los nuevos valores" do
          response.should have_selector("td", :content => "4,65")
          response.should have_selector("td", :content => "13/05/2011 23:45")
          response.should have_selector("td", :content => "Bob")
        end

        it "debe retornar a la misma página" do
          response.should render_template('saldos_bancario/edit')
        end

        it "debe mostrar un mensaje exitoso" do
          response.should have_selector("div.flash.success")
        end

        it "el mensaje exitoso debe desaparecer cuando se cambia de página" do
          visit root_path
          response.should_not have_selector("div.flash.success")
        end
      end

      describe "fallido" do
        it "no debe permitir actualizar con valor cero" do
          fill_in :saldo_bancario_valor, :with => "0"
          click_button
          response.should have_selector("div#error_explanation")
          response.should render_template('saldos_bancario/edit')
          response.should have_selector("td", :content => "13,56")
          response.should have_selector("td", :content => @fecha)
          response.should have_selector("td", :content => "Michael Hartl")
        end

        it "no debe permitir actualizar con valor vacio" do
          fill_in :saldo_bancario_valor, :with => ""
          click_button
          response.should have_selector("div#error_explanation")
          response.should render_template('saldos_bancario/edit')
          response.should have_selector("td", :content => "13,56")
          response.should have_selector("td", :content => @fecha)
          response.should have_selector("td", :content => "Michael Hartl")
        end

        it "no debe permitir actualizar con valor negativo" do
          fill_in :saldo_bancario_valor, :with => "-1"
          click_button
          response.should have_selector("div#error_explanation")
          response.should render_template('saldos_bancario/edit')
          response.should have_selector("td", :content => "13,56")
          response.should have_selector("td", :content => @fecha)
          response.should have_selector("td", :content => "Michael Hartl")
        end

        it "no debe permitir actualizar con valores no numéricos" do
          fill_in :saldo_bancario_valor, :with => "a"
          click_button
          response.should have_selector("div#error_explanation")
          response.should render_template('saldos_bancario/edit')
          response.should have_selector("td", :content => "13,56")
          response.should have_selector("td", :content => @fecha)
          response.should have_selector("td", :content => "Michael Hartl")
        end
      end

    end
  end
end
