#encoding: utf-8

require 'spec_helper'

describe MotivoDeBajaPresupuestaria do
  before(:each) do
    @attr = {:detalle => "detalle1"}
  end

  it "con atributos válidos debe crear una nueva instancia" do
    MotivoDeBajaPresupuestaria.create!(@attr)
  end

  it "debe tener el atributo detalle" do
    MotivoDeBajaPresupuestaria.create!(@attr).should respond_to(:detalle)
  end

  describe "validations" do
    it "should require a detalle" do
      MotivoDeBajaPresupuestaria.new(@attr.merge(:detalle => "")).should_not be_valid
    end
  end
end
