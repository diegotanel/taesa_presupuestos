#encoding: utf-8

require 'spec_helper'

describe Banco do
  before(:each) do
    @attr = {:detalle => "detalle1"}
  end

  it "con atributos válidos debe crear una nueva instancia" do
    Banco.create!(@attr)
  end

  it "debe tener el atributo detalle" do
    Banco.create!(@attr).should respond_to(:detalle)
  end

  describe "validations" do
    it "should require a detalle" do
      Banco.new(@attr.merge(:detalle => "")).should_not be_valid
    end
  end

  describe "Asociación con empresa" do
    before do
      @banco = Banco.create!(@attr)
    end

    it "debe responder a empresas" do
      @banco.should respond_to(:empresas)
    end

    describe "verificación de asociación" do
      before do
        @empresa1 = Empresa.new(:detalle => "Taesa")
        @empresa2 = Empresa.new(:detalle => "Chantaco")
        @empresas = [@empresa1, @empresa2]
        @banco.empresas = @empresas
      end

      it "debe tener los bancos asociados" do
        @banco.empresas.should == @empresas
      end
    end
  end
end
