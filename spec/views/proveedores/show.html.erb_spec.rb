require 'spec_helper'

describe "proveedores/show" do
  before(:each) do
    @proveedor = assign(:proveedor, stub_model(Proveedor,
      :detalle => "Detalle"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Detalle/)
  end
end
