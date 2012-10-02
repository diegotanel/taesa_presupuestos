require 'spec_helper'

describe "medios_de_pago/index" do
  before(:each) do
    assign(:medios_de_pago, [
      stub_model(MedioDePago,
        :detalle => "Detalle"
      ),
      stub_model(MedioDePago,
        :detalle => "Detalle"
      )
    ])
  end

  it "renders a list of medios_de_pago" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Detalle".to_s, :count => 2
  end
end
