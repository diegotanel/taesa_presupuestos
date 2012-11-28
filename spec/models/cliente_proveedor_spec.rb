#encoding: utf-8

require 'spec_helper'

describe ClienteProveedor do
  before(:each) do
    @attr = {:detalle => "detalle1"}
  end

  it "con atributos válidos debe crear una nueva instancia" do
    ClienteProveedor.create!(@attr)
  end

  it "debe tener el atributo detalle" do
    ClienteProveedor.create!(@attr).should respond_to(:detalle)
  end

  it "debe tener el atributo cliente" do
    ClienteProveedor.create!(@attr).should respond_to(:cliente)
  end

  it "debe tener el atributo proveedor" do
    ClienteProveedor.create!(@attr).should respond_to(:proveedor)
  end

  describe "validations" do
    it "should require a detalle" do
      ClienteProveedor.new(@attr.merge(:detalle => "")).should_not be_valid
    end
  end
end
