#encoding: utf-8

require 'spec_helper'

describe "SaldoBancarioHistoricos" do
  describe "GET /saldos_bancario_historico" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get saldos_bancario_historico_path
      response.status.should be(200)
    end
  end

  describe "inicialización" do
    before do
      @user = Factory(:user)
      @fecha = "25/09/2012 23:06"
      @saldo = Factory(:saldo_bancario, :user => @user, :updated_at => @fecha)
    end

    it "link de acceso" do
      visit edit_saldo_bancario_path(@saldo)
      response.should have_selector("a", :href => saldos_bancario_historico_path, :content => "Saldo bancario histórico")
      click_link "Saldo bancario histórico"
      response.should render_template('saldos_bancario_historico/index')
    end

    it "link volver" do
    	@sbh = Factory(:saldo_bancario_historico, :user => @user, :saldo_bancario => @saldo, :fecha_de_alta => @saldo.updated_at)
      visit saldos_bancario_historico_path
      response.should have_selector("a", :href => edit_saldo_bancario_path(@saldo), :content => "Atras")
      click_link "Atras"
      response.should render_template('saldos_bancario/edit')
    end

    describe "exitoso" do
      before do
        @secondUser = Factory(:user, :name => "Bob", :email => "another@example.com")
        integration_sign_in(@secondUser)
        @fechaActualizacion = Time.zone.parse("13/05/2011 23:45")
        Time.stub!(:now).and_return(@fechaActualizacion)
        visit edit_saldo_bancario_path(@saldo)
      end

      it "debe ingresarse un nuevo histórico" do
        fill_in :saldo_bancario_valor, :with => "1"
        click_button
        visit saldos_bancario_historico_path
        response.should have_selector("td", :content => "13,56")
        response.should have_selector("td", :content => @fecha)
        response.should have_selector("td", :content => "Michael Hartl")
      end

      it "no debe actualizarse el histórico" do
        fill_in :saldo_bancario_valor, :with => "a"
        click_button
        visit saldos_bancario_historico_path
        response.should_not have_selector("td", :content => "13,56")
        response.should_not have_selector("td", :content => @fecha)
        response.should_not have_selector("td", :content => "Michael Hartl")
      end
    end
  end
end
