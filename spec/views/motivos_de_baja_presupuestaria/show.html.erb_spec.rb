require 'spec_helper'

describe "motivos_de_baja_presupuestaria/show" do
  before(:each) do
    @motivo_de_baja_presupuestaria = assign(:motivo_de_baja_presupuestaria, stub_model(MotivoDeBajaPresupuestaria,
      :detalle => "Detalle"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Detalle/)
  end
end
