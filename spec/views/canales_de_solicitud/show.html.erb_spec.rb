require 'spec_helper'

describe "canales_de_solicitud/show" do
  before(:each) do
    @canal_de_solicitud = assign(:canal_de_solicitud, stub_model(CanalDeSolicitud,
      :detalle => "Detalle"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Detalle/)
  end
end
