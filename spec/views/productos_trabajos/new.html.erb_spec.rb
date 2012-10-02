require 'spec_helper'

describe "productos_trabajos/new" do
  before(:each) do
    assign(:producto_trabajo, stub_model(ProductoTrabajo,
      :detalle => "MyString"
    ).as_new_record)
  end

  it "renders new producto_trabajo form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => productos_trabajos_path, :method => "post" do
      assert_select "input#producto_trabajo_detalle", :name => "producto_trabajo[detalle]"
    end
  end
end
