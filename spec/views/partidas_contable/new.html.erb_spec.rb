require 'spec_helper'

describe "partidas_contable/new" do
  before(:each) do
    assign(:partida_contable, stub_model(PartidaContable,
      :empresa => nil,
      :banco => nil,
      :solicitante => nil,
      :canal_de_solicitud => nil,
      :rubro => nil,
      :importe => 1,
      :movimiento => "MyString",
      :tipo_de_movimiento_id => 1,
      :tipo_de_movimiento_type => "MyString",
      :detalle => "MyString",
      :producto_trabajo => nil,
      :medio_de_pago => nil,
      :estado => "MyString",
      :motivo_de_baja_presupuestaria => nil
    ).as_new_record)
  end

  it "renders new partida_contable form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => partidas_contable_path, :method => "post" do
      assert_select "input#partida_contable_empresa", :name => "partida_contable[empresa]"
      assert_select "input#partida_contable_banco", :name => "partida_contable[banco]"
      assert_select "input#partida_contable_solicitante", :name => "partida_contable[solicitante]"
      assert_select "input#partida_contable_canal_de_solicitud", :name => "partida_contable[canal_de_solicitud]"
      assert_select "input#partida_contable_rubro", :name => "partida_contable[rubro]"
      assert_select "input#partida_contable_importe", :name => "partida_contable[importe]"
      assert_select "input#partida_contable_movimiento", :name => "partida_contable[movimiento]"
      assert_select "input#partida_contable_tipo_de_movimiento_id", :name => "partida_contable[tipo_de_movimiento_id]"
      assert_select "input#partida_contable_tipo_de_movimiento_type", :name => "partida_contable[tipo_de_movimiento_type]"
      assert_select "input#partida_contable_detalle", :name => "partida_contable[detalle]"
      assert_select "input#partida_contable_producto_trabajo", :name => "partida_contable[producto_trabajo]"
      assert_select "input#partida_contable_medio_de_pago", :name => "partida_contable[medio_de_pago]"
      assert_select "input#partida_contable_estado", :name => "partida_contable[estado]"
      assert_select "input#partida_contable_motivo_de_baja_presupuestaria", :name => "partida_contable[motivo_de_baja_presupuestaria]"
    end
  end
end
