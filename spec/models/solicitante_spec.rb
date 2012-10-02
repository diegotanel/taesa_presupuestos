#encoding: utf-8

require 'spec_helper'

describe Solicitante do
  before(:each) do
    @attr = {:detalle => "detalle1"}
  end

  it "con atributos válidos debe crear una nueva instancia" do
    Solicitante.create!(@attr)
  end

  it "debe tener el atributo detalle" do
    Solicitante.create!(@attr).should respond_to(:detalle)
  end

  describe "validations" do
    it "should require a detalle" do
      Solicitante.new(@attr.merge(:detalle => "")).should_not be_valid
    end
  end
end
