require 'spec_helper'

describe CotizacionPesoDolarHistorico do
  before do
    @user = Factory(:user)
    @fecha = "25/09/2012 23:06"
    @cotizacion = Factory(:cotizacion_peso_dolar, :user => @user, :updated_at => @fecha)
    @attr = {:user_id => @user.id, :cotizacion_peso_dolar => @cotizacion, :valor => @cotizacion.valor_cents, :valor_currency => @cotizacion.valor_currency, :fecha_de_alta => @cotizacion.updated_at}
  end

  describe "exitoso" do
    it "debe guardarse correctamente" do
      CotizacionPesoDolarHistorico.create!(@attr)
    end

    describe "asociaciones" do
      before do
        @cpdh = CotizacionPesoDolarHistorico.create!(@attr)
      end

      it "should have a user attribute" do
        @cpdh.should respond_to(:user)
      end

      it "should have a cotizacion_peso_dolar attribute" do
        @cpdh.should respond_to(:cotizacion_peso_dolar)
      end

      it "should have a fecha_de_alta attribute" do
        @cpdh.should respond_to(:fecha_de_alta)
      end

      it "should have a valor attribute" do
        @cpdh.should respond_to(:valor)
      end

      it "should have a valor_cents attribute" do
        @cpdh.should respond_to(:valor_cents)
      end

      it "should have a valor_currency attribute" do
        @cpdh.should respond_to(:valor_currency)
      end

      it "should have the right associated user" do
        @cpdh.user_id.should == @user.id
        @cpdh.user.should == @user
      end

      it "valor es del tipo money" do
        @cpdh.valor == Money.new(@attr[:valor], @attr[:valor_currency])
      end
    end
  end

  describe "fallido" do

    it "el usuario no debe ser nulo" do
      CotizacionPesoDolarHistorico.new(@attr.merge(:user_id => nil)).should_not be_valid
    end

    it "la cotizacion peso dolar no debe ser nulo" do
      CotizacionPesoDolarHistorico.new(@attr.merge(:cotizacion_peso_dolar => nil)).should_not be_valid
    end

    it "el valor de la cotizacion peso dolar no debe ser nulo" do
      CotizacionPesoDolarHistorico.new(@attr.merge(:valor => nil)).should_not be_valid
    end

    it "el valor de la cotizacion peso dolar no debe ser vacio" do
      CotizacionPesoDolarHistorico.new(@attr.merge(:valor => "")).should_not be_valid
    end

    it "el valor de la cotizacion peso dolar no debe ser nulo" do
      CotizacionPesoDolarHistorico.new(@attr.merge(:valor_cents => nil)).should_not be_valid
    end

    it "el valor de la cotizacion peso dolar no debe ser vacio" do
      CotizacionPesoDolarHistorico.new(@attr.merge(:valor_cents => "")).should_not be_valid
    end

    it "la moneda de la cotizacion peso dolar no debe ser nula" do
      CotizacionPesoDolarHistorico.new(@attr.merge(:valor_currency => nil)).should_not be_valid
    end

    it "la moneda de la cotizacion peso dolar no debe ser vacia" do
      CotizacionPesoDolarHistorico.new(@attr.merge(:valor_currency => "")).should_not be_valid
    end

    it "la fecha de alta de la cotizacion peso dolar no debe ser nula" do
      CotizacionPesoDolarHistorico.new(@attr.merge(:fecha_de_alta => nil)).should_not be_valid
    end

    it "la fecha de alta de la cotizacion peso dolar no debe ser vacia" do
      CotizacionPesoDolarHistorico.new(@attr.merge(:fecha_de_alta => "")).should_not be_valid
    end
  end

end

