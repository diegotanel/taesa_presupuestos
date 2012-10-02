require 'spec_helper'

describe "productos_trabajos/show" do
  before(:each) do
    @producto_trabajo = assign(:producto_trabajo, stub_model(ProductoTrabajo,
      :detalle => "Detalle"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Detalle/)
  end
end
