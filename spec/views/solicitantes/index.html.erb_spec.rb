require 'spec_helper'

describe "solicitantes/index" do
  before(:each) do
    assign(:solicitantes, [
      stub_model(Solicitante,
        :detalle => "Detalle"
      ),
      stub_model(Solicitante,
        :detalle => "Detalle"
      )
    ])
  end

  it "renders a list of solicitantes" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Detalle".to_s, :count => 2
  end
end
