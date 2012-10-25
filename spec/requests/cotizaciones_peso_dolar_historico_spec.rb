#encoding: utf-8

require 'spec_helper'

describe "CotizacionesPesoDolarHistorico" do
  describe "GET /cotizaciones_peso_dolar_historico" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get cotizaciones_peso_dolar_historico_path
      response.status.should be(200)
    end
  end

  describe "inicialización" do
    before do
      @user = Factory(:user)
      @fecha = "25/09/2012 23:06"
      @cotizacion = Factory(:cotizacion_peso_dolar, :user => @user, :updated_at => @fecha)
    end

    it "link de acceso" do
      visit edit_cotizacion_peso_dolar_path(@cotizacion)
      response.should have_selector("a", :href => cotizaciones_peso_dolar_historico_path, :content => "Cotización peso dolar histórico")
      click_link "Cotización peso dolar histórico"
      response.should render_template('cotizaciones_peso_dolar_historico/index')
    end

    it "link volver" do
    	@cotizacion = Factory(:cotizacion_peso_dolar_historico, :user => @user, :cotizacion_peso_dolar => @cotizacion)
      visit cotizaciones_peso_dolar_historico_path
      response.should have_selector("a", :href => edit_cotizacion_peso_dolar_path(@cotizacion), :content => "Atras")
      click_link "Atras"
      response.should render_template('cotizaciones_peso_dolar/edit')
    end

    describe "exitoso" do
      before do
        @secondUser = Factory(:user, :name => "Bob", :email => "another@example.com")
        integration_sign_in(@secondUser)
        @fechaActualizacion = Time.zone.parse("13/05/2011 23:45")
        Time.stub!(:now).and_return(@fechaActualizacion)
        visit edit_cotizacion_peso_dolar_path(@cotizacion)
      end

      it "debe ingresarse un nuevo histórico" do
        fill_in :cotizacion_peso_dolar_valor, :with => "1"
        click_button
        visit cotizaciones_peso_dolar_historico_path
        response.should have_selector("td", :content => "13,56")
        response.should have_selector("td", :content => "13/05/2011 23:45")
        response.should have_selector("td", :content => "Michael Hartl")
      end

      it "no debe actualizarse el histórico" do
        fill_in :cotizacion_peso_dolar_valor, :with => "a"
        click_button
        visit cotizaciones_peso_dolar_historico_path
        response.should_not have_selector("td", :content => "13,56")
        response.should_not have_selector("td", :content => @fecha)
        response.should_not have_selector("td", :content => "Michael Hartl")
      end
    end
  end
end
