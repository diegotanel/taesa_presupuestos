require 'spec_helper'

describe "clientes_proveedores/show" do
  before(:each) do
    @cliente_proveedor = assign(:cliente_proveedor, stub_model(ClienteProveedor,
      :detalle => "Detalle",
      :cliente => false,
      :proveedor => false
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Detalle/)
    rendered.should match(/false/)
    rendered.should match(/false/)
  end
end
