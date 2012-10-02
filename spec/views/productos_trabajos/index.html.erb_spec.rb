require 'spec_helper'

describe "productos_trabajos/index" do
  before(:each) do
    assign(:productos_trabajos, [
      stub_model(ProductoTrabajo,
        :detalle => "Detalle"
      ),
      stub_model(ProductoTrabajo,
        :detalle => "Detalle"
      )
    ])
  end

  it "renders a list of productos_trabajos" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Detalle".to_s, :count => 2
  end
end
