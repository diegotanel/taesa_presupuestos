#encoding: utf-8

require 'spec_helper'

describe Empresa do
  before(:each) do
    @attr = {:detalle => "detalle1"}
  end

  it "con atributos válidos debe crear una nueva instancia" do
    Empresa.create!(@attr)
  end

  it "debe tener el atributo detalle" do
    Empresa.create!(@attr).should respond_to(:detalle)
  end

  describe "validations" do
    it "should require a detalle" do
      Empresa.new(@attr.merge(:detalle => "")).should_not be_valid
    end
  end

  describe "Asociación con banco" do
    before do
      @empresa = Empresa.create!(@attr)
    end

    it "debe responder a bancos" do
      @empresa.should respond_to(:bancos)
    end

    describe "verificación de asociación" do
      before do
        @banco1 = Banco.new(:detalle => "Banco Galicia")
        @banco2 = Banco.new(:detalle => "Banco Frances")
        @bancos = [@banco1, @banco2]
        @empresa.bancos = @bancos
      end

      it "debe tener los bancos asociados" do
        @empresa.bancos.should == @bancos
      end

    end
  end
end
