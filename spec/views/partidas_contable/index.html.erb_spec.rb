require 'spec_helper'

describe "partidas_contable/index" do
  before(:each) do
    assign(:partidas_contable, [
      stub_model(PartidaContable,
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
      ),
      stub_model(PartidaContable,
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
      )
    ])
  end

  it "renders a list of partidas_contable" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Movimiento".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Tipo De Movimiento Type".to_s, :count => 2
    assert_select "tr>td", :text => "Detalle".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Estado".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
