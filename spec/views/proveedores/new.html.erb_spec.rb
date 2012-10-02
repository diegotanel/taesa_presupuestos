require 'spec_helper'

describe "proveedores/new" do
  before(:each) do
    assign(:proveedor, stub_model(Proveedor,
      :detalle => "MyString"
    ).as_new_record)
  end

  it "renders new proveedor form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => proveedores_path, :method => "post" do
      assert_select "input#proveedor_detalle", :name => "proveedor[detalle]"
    end
  end
end
