require 'spec_helper'

describe "solicitantes/show" do
  before(:each) do
    @solicitante = assign(:solicitante, stub_model(Solicitante,
      :detalle => "Detalle"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Detalle/)
  end
end
