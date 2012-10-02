require 'spec_helper'

describe "medios_de_pago/show" do
  before(:each) do
    @medio_de_pago = assign(:medio_de_pago, stub_model(MedioDePago,
      :detalle => "Detalle"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Detalle/)
  end
end
