require 'spec_helper'

describe "bancos/index" do
  before(:each) do
    assign(:bancos, [
      stub_model(Banco,
        :detalle => "Detalle"
      ),
      stub_model(Banco,
        :detalle => "Detalle"
      )
    ])
  end

  it "renders a list of bancos" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Detalle".to_s, :count => 2
  end
end
