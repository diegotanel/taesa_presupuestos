require 'spec_helper'

describe "proveedores/index" do
  before(:each) do
    assign(:proveedores, [
      stub_model(Proveedor,
        :detalle => "Detalle"
      ),
      stub_model(Proveedor,
        :detalle => "Detalle"
      )
    ])
  end

  it "renders a list of proveedores" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Detalle".to_s, :count => 2
  end
end
