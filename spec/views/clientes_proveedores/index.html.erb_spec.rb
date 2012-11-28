require 'spec_helper'

describe "clientes_proveedores/index" do
  before(:each) do
    assign(:clientes_proveedores, [
      stub_model(ClienteProveedor,
        :detalle => "Detalle",
        :cliente => false,
        :proveedor => false
      ),
      stub_model(ClienteProveedor,
        :detalle => "Detalle",
        :cliente => false,
        :proveedor => false
      )
    ])
  end

  it "renders a list of clientes_proveedores" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Detalle".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
