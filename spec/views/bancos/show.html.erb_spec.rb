require 'spec_helper'

describe "bancos/show" do
  before(:each) do
    @banco = assign(:banco, stub_model(Banco,
      :detalle => "Detalle"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Detalle/)
  end
end
