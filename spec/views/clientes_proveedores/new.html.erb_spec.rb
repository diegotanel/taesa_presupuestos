require 'spec_helper'

describe "clientes_proveedores/new" do
  before(:each) do
    assign(:cliente_proveedor, stub_model(ClienteProveedor,
      :detalle => "MyString",
      :cliente => false,
      :proveedor => false
    ).as_new_record)
  end

  it "renders new cliente_proveedor form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => clientes_proveedores_path, :method => "post" do
      assert_select "input#cliente_proveedor_detalle", :name => "cliente_proveedor[detalle]"
      assert_select "input#cliente_proveedor_cliente", :name => "cliente_proveedor[cliente]"
      assert_select "input#cliente_proveedor_proveedor", :name => "cliente_proveedor[proveedor]"
    end
  end
end
