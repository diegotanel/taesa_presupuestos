require 'spec_helper'

describe "rubros/index" do
  before(:each) do
    assign(:rubros, [
      stub_model(Rubro,
        :detalle => "Detalle"
      ),
      stub_model(Rubro,
        :detalle => "Detalle"
      )
    ])
  end

  it "renders a list of rubros" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Detalle".to_s, :count => 2
  end
end
