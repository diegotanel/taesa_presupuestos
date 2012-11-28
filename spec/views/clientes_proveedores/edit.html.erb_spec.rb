require 'spec_helper'

describe "clientes_proveedores/edit" do
  before(:each) do
    @cliente_proveedor = assign(:cliente_proveedor, stub_model(ClienteProveedor,
      :detalle => "MyString",
      :cliente => false,
      :proveedor => false
    ))
  end

  it "renders the edit cliente_proveedor form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => clientes_proveedores_path(@cliente_proveedor), :method => "post" do
      assert_select "input#cliente_proveedor_detalle", :name => "cliente_proveedor[detalle]"
      assert_select "input#cliente_proveedor_cliente", :name => "cliente_proveedor[cliente]"
      assert_select "input#cliente_proveedor_proveedor", :name => "cliente_proveedor[proveedor]"
    end
  end
end
