#encoding: utf-8

require 'spec_helper'

describe "PartidaContables" do
  describe "GET /partidas_contable" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get partidas_contable_path
      response.status.should be(200)
    end
  end

  it "dar por cumplida"

  it "link de acceso a la lista de cancelaciones" do
    @pc = Factory(:partida_contable)
    visit partidas_contable_path
    response.should have_selector("a", :href => partida_contable_cancelaciones_path(@pc), :content => "Cancelación")
    click_link "Cancelación"
    response.should render_template('cancelaciones/index')
  end

  describe "alta de partida contable" do
    before do
      Factory(:cotizacion_peso_dolar)
      Factory(:empresa)
      Factory(:banco)
      Factory(:solicitante)
      Factory(:canal_de_solicitud)
      Factory(:rubro)
      Factory(:cliente_proveedor)
      Factory(:producto_trabajo)
    end

    describe "exitoso" do
      before do
        fechaDeCreacion = Time.zone.parse("17/05/2012 23:45")
        Time.stub!(:now).and_return(fechaDeCreacion)
        visit new_partida_contable_path
        select "15"
        select "mayo"
        select "2012"
        select "TAESA", :from => :partida_contable_empresa_id
        # select "Banco Frances", :from => :partida_contable_banco_id
        select "Fernando", :from => :partida_contable_solicitante_id
        select "Mail", :from => :partida_contable_canal_de_solicitud_id
        select "Impuestos", :from => :partida_contable_rubro_id
        select "ARS", :from => :partida_contable_importe_currency
        fill_in :partida_contable_importe, :with => "105,98"
        select "entrada", :from => :partida_contable_tipo_de_movimiento
        select "Jukic", :from => :partida_contable_cliente_proveedor_id
        select "Cosecha", :from => :partida_contable_producto_trabajo_id
        click_button
      end

      it "debe retornar la vista de sola lectura" do
        response.should have_selector("p", :content => "15/05/2012")
        response.should have_selector("p", :content => "TAESA")
        response.should have_selector("p", :content => "Fernando")
        response.should have_selector("p", :content => "Mail")
        response.should have_selector("p", :content => "Impuestos")
        response.should have_selector("p", :content => "ARS")
        response.should have_selector("p", :content => "105,98")
        response.should have_selector("p", :content => "entrada")
        response.should have_selector("p", :content => "Jukic")
        response.should have_selector("p", :content => "Cosecha")
        response.should render_template('partidas_contable/show')
      end

    end

  end

end
