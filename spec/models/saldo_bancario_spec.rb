#encoding: utf-8

require 'spec_helper'

describe SaldoBancario do
  before(:each) do
    @user = Factory(:user)
    @banco = Factory(:banco)
    @empresa = Factory(:empresa)
    @attr = {:user_id => @user, :valor => 1356, :valor_currency => "EUR", :banco_id => @banco.id, :empresa_id => @empresa.id }
  end

  it "con atributos válidos debe crear una nueva instancia" do
    SaldoBancario.create!(@attr)
  end

  describe "debe responder a las propiedades" do

    before(:each) do
      @SaldoBancario = SaldoBancario.create(@attr)
    end

    it "should have a user attribute" do
      @SaldoBancario.should respond_to(:user)
    end

    it "should have a valor attribute" do
      @SaldoBancario.should respond_to(:valor)
    end

    it "should have a valor_cents attribute" do
      @SaldoBancario.should respond_to(:valor_cents)
    end

    it "should have a valor_currency attribute" do
      @SaldoBancario.should respond_to(:valor_currency)
    end

    it "should have a detalle attribute" do
      @SaldoBancario.should respond_to(:detalle)
    end

    it "should have a detalle attribute" do
      @SaldoBancario.should respond_to(:tipo_de_movimiento)
    end

    it "should have the right associated user" do
      @SaldoBancario.user_id.should == @user.id
      @SaldoBancario.user.should == @user
    end

    it "should have the right associated banco" do
      @SaldoBancario.banco_id.should == @banco.id
      @SaldoBancario.banco.should == @banco
    end

    it "should have the right associated empresa" do
      @SaldoBancario.empresa_id.should == @empresa.id
      @SaldoBancario.empresa.should == @empresa
    end

    it "valor es del tipo money" do
      @SaldoBancario.valor == Money.new(@attr[:valor], @attr[:valor_currency])
    end

    it "no puede exisir dos saldos de la misma empresa y banco" do
      SaldoBancario.create(@attr).should_not be_valid
    end

    it "debe retornar el detalle correcto" do
      nombre = "Saldo Bancario Banco Frances Contable"
      @SaldoBancario.detalle.should == nombre
    end

     it "debe retornar el tipo_de_movimiento correcto" do
      @SaldoBancario.tipo_de_movimiento.should == PartidaContable::TIPODEMOVIMIENTO[:entrada]
    end

  end


  describe "validations" do

    it "should require a user id" do
      SaldoBancario.new(@attr.merge(:user_id => "")).should_not be_valid
    end

    it "should require a banco id" do
      SaldoBancario.new(@attr.merge(:banco_id => "")).should_not be_valid
    end

    it "should require a empresa id" do
      SaldoBancario.new(@attr.merge(:empresa_id => "")).should_not be_valid
    end

    it "should require number content" do
      SaldoBancario.new(@attr.merge(:valor => "a")).should_not be_valid
    end

    it "should require non nil content" do
      SaldoBancario.new(@attr.merge(:valor => nil)).should_not be_valid
    end

    it "should require nonblank content" do
      SaldoBancario.new(@attr.merge(:valor => "")).should_not be_valid
    end

    it "puede ser cero" do
      SaldoBancario.new(@attr.merge(:valor => 0)).should be_valid
    end

    it "puede ser cero con decimales" do
      SaldoBancario.new(@attr.merge(:valor => "0,00")).should be_valid
    end

    it "puede ser inferior a cero" do
      SaldoBancario.new(@attr.merge(:valor => "-0,01")).should be_valid
    end

    it "should require nonblank content" do
      SaldoBancario.new(@attr.merge(:valor_currency => "")).should_not be_valid
    end
  end
end
