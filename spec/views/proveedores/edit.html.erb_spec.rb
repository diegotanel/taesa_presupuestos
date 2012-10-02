require 'spec_helper'

describe "proveedores/edit" do
  before(:each) do
    @proveedor = assign(:proveedor, stub_model(Proveedor,
      :detalle => "MyString"
    ))
  end

  it "renders the edit proveedor form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => proveedores_path(@proveedor), :method => "post" do
      assert_select "input#proveedor_detalle", :name => "proveedor[detalle]"
    end
  end
end
