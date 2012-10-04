require 'spec_helper'

describe "partidas_contable/show" do
  before(:each) do
    @partida_contable = assign(:partida_contable, stub_model(PartidaContable,
      :empresa => nil,
      :banco => nil,
      :solicitante => nil,
      :canal_de_solicitud => nil,
      :rubro => nil,
      :importe => 1,
      :movimiento => "Movimiento",
      :tipo_de_movimiento_id => 2,
      :tipo_de_movimiento_type => "Tipo De Movimiento Type",
      :detalle => "Detalle",
      :producto_trabajo => nil,
      :medio_de_pago => nil,
      :estado => "Estado",
      :motivo_de_baja_presupuestaria => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(/1/)
    rendered.should match(/Movimiento/)
    rendered.should match(/2/)
    rendered.should match(/Tipo De Movimiento Type/)
    rendered.should match(/Detalle/)
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(/Estado/)
    rendered.should match(//)
  end
end
