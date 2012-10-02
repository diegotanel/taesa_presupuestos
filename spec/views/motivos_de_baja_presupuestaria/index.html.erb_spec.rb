require 'spec_helper'

describe "motivos_de_baja_presupuestaria/index" do
  before(:each) do
    assign(:motivos_de_baja_presupuestaria, [
      stub_model(MotivoDeBajaPresupuestaria,
        :detalle => "Detalle"
      ),
      stub_model(MotivoDeBajaPresupuestaria,
        :detalle => "Detalle"
      )
    ])
  end

  it "renders a list of motivos_de_baja_presupuestaria" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Detalle".to_s, :count => 2
  end
end
