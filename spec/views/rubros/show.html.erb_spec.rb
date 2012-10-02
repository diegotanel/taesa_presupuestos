require 'spec_helper'

describe "rubros/show" do
  before(:each) do
    @rubro = assign(:rubro, stub_model(Rubro,
      :detalle => "Detalle"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Detalle/)
  end
end
