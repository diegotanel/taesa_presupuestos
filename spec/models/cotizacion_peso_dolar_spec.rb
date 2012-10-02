#encoding: utf-8

require 'spec_helper'

describe CotizacionPesoDolar do
  before(:each) do
    @user = Factory(:user)
    @attr = {:user_id => @user, :valor => 1356, :valor_currency => "EUR"}
  end

  it "con atributos válidos debe crear una nueva instancia" do
    CotizacionPesoDolar.create!(@attr)
  end

  describe "asociación con user" do

    before(:each) do
      @cotizacionPesoDolar = CotizacionPesoDolar.create(@attr)
    end

    it "should have a user attribute" do
      @cotizacionPesoDolar.should respond_to(:user)
    end

    it "should have a valor attribute" do
      @cotizacionPesoDolar.should respond_to(:valor)
    end

    it "should have a valor_cents attribute" do
      @cotizacionPesoDolar.should respond_to(:valor_cents)
    end

    it "should have a valor_currency attribute" do
      @cotizacionPesoDolar.should respond_to(:valor_currency)
    end

    it "should have the right associated user" do
      @cotizacionPesoDolar.user_id.should == @user.id
      @cotizacionPesoDolar.user.should == @user
    end

    it "valor es del tipo money" do
      @cotizacionPesoDolar.valor == Money.new(@attr[:valor], @attr[:valor_currency])
    end

    describe "validations" do

      it "should require a user id" do
        CotizacionPesoDolar.new(@attr.merge(:user_id => "")).should_not be_valid
      end

      it "should require nonblank content" do
        CotizacionPesoDolar.new(@attr.merge(:valor => "")).should_not be_valid
      end

      it "no puede ser cero" do
        CotizacionPesoDolar.new(@attr.merge(:valor => 0.00)).should_not be_valid
      end

      it "no puede ser inferior a cero" do
        CotizacionPesoDolar.new(@attr.merge(:valor => -0.01)).should_not be_valid
      end

      it "should require nonblank content" do
        CotizacionPesoDolar.new(@attr.merge(:valor_currency => "")).should_not be_valid
      end

    end


  end
end
