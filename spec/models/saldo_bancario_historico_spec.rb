require 'spec_helper'

describe SaldoBancarioHistorico do
  before do
    @user = Factory(:user)
    @fecha = "25/09/2012 23:06"
    @saldo = Factory(:saldo_bancario, :user => @user, :updated_at => @fecha)
    @attr = {:user_id => @user.id, :saldo_bancario => @saldo, :valor => @saldo.valor_cents, :valor_currency => @saldo.valor_currency, :fecha_de_alta => @saldo.updated_at}
  end

  describe "exitoso" do
    it "debe guardarse correctamente" do
      SaldoBancarioHistorico.create!(@attr)
    end

    describe "asociaciones" do
      before do
        @sbh = SaldoBancarioHistorico.create!(@attr)
      end

      it "should have a user attribute" do
        @sbh.should respond_to(:user)
      end

      it "should have a saldo_bancario attribute" do
        @sbh.should respond_to(:saldo_bancario)
      end

      it "should have a fecha_de_alta attribute" do
        @sbh.should respond_to(:fecha_de_alta)
      end

      it "should have a valor attribute" do
        @sbh.should respond_to(:valor)
      end

      it "should have a valor_cents attribute" do
        @sbh.should respond_to(:valor_cents)
      end

      it "should have a valor_currency attribute" do
        @sbh.should respond_to(:valor_currency)
      end

      it "should have the right associated user" do
        @sbh.user_id.should == @user.id
        @sbh.user.should == @user
      end

      it "valor es del tipo money" do
        @sbh.valor == Money.new(@attr[:valor], @attr[:valor_currency])
      end
    end
  end

  describe "fallido" do

    it "el usuario no debe ser nulo" do
      SaldoBancarioHistorico.new(@attr.merge(:user_id => nil)).should_not be_valid
    end

    it "el saldo bancario no debe ser nulo" do
      SaldoBancarioHistorico.new(@attr.merge(:saldo_bancario => nil)).should_not be_valid
    end

    it "el valor del saldo bancario no debe ser nulo" do
      SaldoBancarioHistorico.new(@attr.merge(:valor => nil)).should_not be_valid
    end

    it "el valor del saldo bancario no debe ser vacio" do
      SaldoBancarioHistorico.new(@attr.merge(:valor => "")).should_not be_valid
    end

    it "el valor del saldo bancario no debe ser nulo" do
      SaldoBancarioHistorico.new(@attr.merge(:valor_cents => nil)).should_not be_valid
    end

    it "el valor del saldo bancario no debe ser vacio" do
      SaldoBancarioHistorico.new(@attr.merge(:valor_cents => "")).should_not be_valid
    end

    it "la moneda del saldo bancario no debe ser nula" do
      SaldoBancarioHistorico.new(@attr.merge(:valor_currency => nil)).should_not be_valid
    end

    it "la moneda del saldo bancario no debe ser vacia" do
      SaldoBancarioHistorico.new(@attr.merge(:valor_currency => "")).should_not be_valid
    end

    it "la fecha de alta del saldo bancario no debe ser nula" do
      SaldoBancarioHistorico.new(@attr.merge(:fecha_de_alta => nil)).should_not be_valid
    end

    it "la fecha de alta del saldo bancario no debe ser vacia" do
      SaldoBancarioHistorico.new(@attr.merge(:fecha_de_alta => "")).should_not be_valid
    end
  end

end
