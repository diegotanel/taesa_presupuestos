require 'spec_helper'

describe "canales_de_solicitud/index" do
  before(:each) do
    assign(:canales_de_solicitud, [
      stub_model(CanalDeSolicitud,
        :detalle => "Detalle"
      ),
      stub_model(CanalDeSolicitud,
        :detalle => "Detalle"
      )
    ])
  end

  it "renders a list of canales_de_solicitud" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Detalle".to_s, :count => 2
  end
end
