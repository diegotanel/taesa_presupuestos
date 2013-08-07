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

    describe "deben inicializarse todos los combobox del formulario en blanco" do
      it "deben inicializarse el combobox de empresa en blanco" do
        visit new_partida_contable_path
        response.should have_selector("select#partida_contable_empresa_id") do |n|
          n.should have_selector('option[value=""]', :content => "Seleccione una empresa...")
          n.should have_selector('option[value="1"]', :content => "TAESA")
        end
      end

      it "deben inicializarse el combobox de banco en blanco" do
        # visit new_partida_contable_path
        # response.should have_selector("select#partida_contable_banco_id") do |n|
        #   n.should have_selector('option[value=""]', :content => "Seleccione un banco...")
        # end
      end

      it "deben inicializarse el combobox de solicitante en blanco" do
        visit new_partida_contable_path
        response.should have_selector("select#partida_contable_solicitante_id") do |n|
          n.should have_selector('option[value=""]', :content => "Seleccione un solicitante...")
          n.should have_selector('option[value="1"]', :content => "Fernando")
        end
      end

      it "deben inicializarse el combobox de canal de solicitud en blanco" do
        visit new_partida_contable_path
        response.should have_selector("select#partida_contable_canal_de_solicitud_id") do |n|
          n.should have_selector('option[value=""]', :content => "Seleccione un canal de solicitud...")
          n.should have_selector('option[value="1"]', :content => "Mail")
        end
      end

      it "deben inicializarse el combobox de rubro en blanco" do
        visit new_partida_contable_path
        response.should have_selector("select#partida_contable_rubro_id") do |n|
          n.should have_selector('option[value=""]', :content => "Seleccione un rubro...")
          n.should have_selector('option[value="1"]', :content => "Impuestos")
        end
      end

      it "deben inicializarse el combobox de tipo de moneda en blanco" do
        visit new_partida_contable_path
        response.should have_selector("select#partida_contable_importe_currency") do |n|
          n.should have_selector('option[value=""]', :content => "Seleccione una moneda...")
          n.should have_selector('option[value="ARS"]', :content => "ARS")
        end
      end

      it "deben inicializarse el combobox de tipo de movimiento en blanco" do
        visit new_partida_contable_path
        response.should have_selector("select#partida_contable_tipo_de_movimiento") do |n|
          n.should have_selector('option[value=""]', :content => "Seleccione un tipo de movimiento...")
          n.should have_selector('option[value="1"]', :content => "entrada")
        end
      end

      it "deben inicializarse el combobox de cliente proveedor en blanco" do
        visit new_partida_contable_path
        response.should have_selector("select#partida_contable_cliente_proveedor_id") do |n|
          n.should have_selector('option[value=""]', :content => "Seleccione un cliente / proveedor...")
          n.should have_selector('option[value="1"]', :content => "Jukic")
        end
      end

      it "deben inicializarse el combobox de producto trabajo en blanco" do
        visit new_partida_contable_path
        response.should have_selector("select#partida_contable_producto_trabajo_id") do |n|
          n.should have_selector('option[value=""]', :content => "Seleccione un producto trabajo...")
          n.should have_selector('option[value="1"]', :content => "Cosecha")
        end
      end

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
        fill_in :partida_contable_detalle, :with => "texto para detalle"
        click_button
      end

      it "debe visualizarse las etiquetas de la vista de solo lectura" do
        response.should have_selector("p", :content => "Número de partida contable")
        response.should have_selector("p", :content => "Fecha de creación")
        response.should have_selector("p", :content => "Fecha de vencimiento")
        response.should have_selector("p", :content => "Empresa")
        response.should have_selector("p", :content => "Banco")
        response.should have_selector("p", :content => "Solicitante")
        response.should have_selector("p", :content => "Canal de solicitud")
        response.should have_selector("p", :content => "Rubro")
        response.should have_selector("p", :content => "Tipo de moneda")
        response.should have_selector("p", :content => "Importe")
        response.should have_selector("p", :content => "Valor dólar")
        response.should have_selector("p", :content => "Tipo de movimiento")
        response.should have_selector("p", :content => "Cliente proveedor")
        response.should have_selector("p", :content => "Producto trabajo")
        response.should have_selector("p", :content => "Detalle")
        response.should have_selector("p", :content => "Estado")
        response.should have_selector("p", :content => "Motivo de baja presupuestaria")
        response.should have_selector("p", :content => "Fecha de baja")
      end

      it "debe retornar la vista de sola lectura" do
        response.should have_selector("p", :content => "15/05/2012")
        response.should have_selector("p", :content => "TAESA")
        response.should have_selector("p", :content => "Fernando")
        response.should have_selector("p", :content => "Mail")
        response.should have_selector("p", :content => "Impuestos")
        response.should have_selector("p", :content => "ARS")
        response.should have_selector("p", :content => "105,98")
        response.should have_selector("p", :content => "13,56")
        response.should have_selector("p", :content => "entrada")
        response.should have_selector("p", :content => "Jukic")
        response.should have_selector("p", :content => "Cosecha")
        response.should have_selector("p", :content => "activa")
        response.should render_template('partidas_contable/show')
      end

      it "debe mostrar los datos ingresados en lista de partidas contables" do
        visit partidas_contable_path
        response.should have_selector("td", :content => "17/05/2012 23:45")
        response.should have_selector("td", :content => "15/05/2012")
        response.should have_selector("td", :content => "TAESA")
        response.should have_selector("td", :content => "Fernando")
        response.should have_selector("td", :content => "Mail")
        response.should have_selector("td", :content => "Impuestos")
        response.should have_selector("td", :content => "105,98")
        response.should have_selector("td", :content => "ARS")
        response.should have_selector("td", :content => "13,56")
        response.should have_selector("td", :content => "entrada")
        response.should have_selector("td", :content => "Jukic")
        response.should have_selector("td", :content => "Cosecha")
        response.should have_selector("td", :content => "activa")
      end

    end

  end

end
