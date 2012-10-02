require 'spec_helper'

describe "productos_trabajos/edit" do
  before(:each) do
    @producto_trabajo = assign(:producto_trabajo, stub_model(ProductoTrabajo,
      :detalle => "MyString"
    ))
  end

  it "renders the edit producto_trabajo form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => productos_trabajos_path(@producto_trabajo), :method => "post" do
      assert_select "input#producto_trabajo_detalle", :name => "producto_trabajo[detalle]"
    end
  end
end
