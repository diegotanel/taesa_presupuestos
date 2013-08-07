#encoding: utf-8

require 'spec_helper'

describe "Cancelaciones" do

  describe "lista de cancelaciones" do
    before do
      @user = Factory(:user)
      integration_sign_in(@user)
      @pc = Factory(:partida_contable)
    end

    it "debe mostrarse el encabezado con los datos de la partida contable actual" do
      @cancelacion = Factory(:cancelacion, :partida_contable => @pc)
      visit partida_contable_cancelaciones_path(@pc)
      response.should have_selector("td", :content => "Partida contable")
      response.should have_selector("td", :content => @pc.id.to_s)
      response.should have_selector("td", :content => "Empresa")
      response.should have_selector("td", :content => @pc.empresa.detalle)
      response.should have_selector("td", :content => "Banco")
      response.should have_selector("td", :content => @pc.banco.detalle)
      response.should have_selector("td", :content => "Moneda")
      response.should have_selector("td", :content => @pc.importe_currency)
      response.should have_selector("content", :td => "Total a cancelar")
      response.should have_selector("td", :content => "13,56")
      response.should have_selector("td", :content => "Importe total cancelado")
      response.should have_selector("td", :content => "6,72")
      response.should have_selector("td", :content => "Resta cancelar")
      response.should have_selector("td", :content => "6,84")
    end

    it "debe mostrar el encabezado en el formulario de alta" do
      @cancelacion = Factory(:cancelacion, :partida_contable => @pc)
      visit new_partida_contable_cancelacion_path(@pc)
      response.should have_selector("td", :content => "Partida contable")
      response.should have_selector("td", :content => @pc.id.to_s)
      response.should have_selector("td", :content => "Empresa")
      response.should have_selector("td", :content => @pc.empresa.detalle)
      response.should have_selector("td", :content => "Banco")
      response.should have_selector("td", :content => @pc.banco.detalle)
      response.should have_selector("td", :content => "Moneda")
      response.should have_selector("td", :content => @pc.importe_currency)
      response.should have_selector("td", :content => "Total a cancelar")
      response.should have_selector("td", :content => "13,56")
      response.should have_selector("td", :content => "Importe total cancelado")
      response.should have_selector("td", :content => "6,72")
      response.should have_selector("td", :content => "Resta cancelar")
      response.should have_selector("td", :content => "6,84")
    end

    it "debe visualizarse las cancelaciones con estado activo en la grilla" do
      fechaDeTransaccion = "13/05/2012 22:41"
      @cancelacion = Factory(:cancelacion, :partida_contable => @pc, :created_at => Time.zone.parse(fechaDeTransaccion))
      fechaDeTransaccionAAnular = "15/06/2012 21:55"
      @cancelacionAnulada = Factory(:cancelacion, :partida_contable => @pc, :created_at => Time.zone.parse(fechaDeTransaccionAAnular), :estado => Cancelacion::ESTADOS[:anulada])
      visit partida_contable_cancelaciones_path(@pc)
      response.should have_selector("td", :content => fechaDeTransaccion)
      response.should_not have_selector("td", :content => fechaDeTransaccionAAnular)
    end

    it "debe visualizarse las cancelaciones de la partida contable correspondiente" do
      fechaDeTransaccion = "13/05/2012 22:41"
      @cancelacion = Factory(:cancelacion, :partida_contable => @pc, :created_at => Time.zone.parse(fechaDeTransaccion))
      @pc2 = Factory(:partida_contable)
      fechaDeTransaccion2 = "15/06/2012 21:55"
      @cancelacion2 = Factory(:cancelacion, :partida_contable => @pc2, :created_at => Time.zone.parse(fechaDeTransaccion2))
      visit partida_contable_cancelaciones_path(@pc)
      response.should have_selector("td", :content => fechaDeTransaccion)
      response.should_not have_selector("td", :content => fechaDeTransaccion2)
      visit partida_contable_cancelaciones_path(@pc2)
      response.should_not have_selector("td", :content => fechaDeTransaccion)
      response.should have_selector("td", :content => fechaDeTransaccion2)
    end

    it "link de alta de cancelación" do
      visit partida_contable_cancelaciones_path(@pc)
      response.should have_selector("a", :href => new_partida_contable_cancelacion_path(@pc), :content => "Alta")
      click_link "Alta"
      response.should render_template('cancelaciones/new')
    end

    it "vista de cancelaciones con una pc con banco no asignado" do
      @pc = Factory(:partida_contable, :banco => nil)
      visit partida_contable_cancelaciones_path(@pc)
      response.should have_selector("a", :href => new_partida_contable_cancelacion_path(@pc), :content => "Alta")
      click_link "Alta"
      response.should render_template('cancelaciones/new')
    end

    it "link para retornar a la lista de partidas contables desde el alta de cancelación" do
      visit new_partida_contable_cancelacion_path(@pc, @pc.cancelaciones.build)
      response.should have_selector("a", :href => partida_contable_cancelaciones_path(@pc), :content => "Atras")
      click_link "Atras"
      response.should render_template('cancelaciones/index')
    end

    it "link para retornar la lista de partidas contables" do
      visit partida_contable_cancelaciones_path(@pc)
      response.should have_selector("a", :href => partidas_contable_path, :content => "Atras")
      click_link "Atras"
      response.should render_template('partidas_contable/index')
    end

    it "debe mostrar los campos del formulario de alta" do
      visit new_partida_contable_cancelacion_path(@pc, @pc.cancelaciones.new)
      response.should have_selector("input", :type => "submit")
      response.should have_selector("label", :content => "Fecha de ingreso")
      response.should have_selector("select#cancelacion_fecha_de_ingreso_3i")
      response.should have_selector("select#cancelacion_fecha_de_ingreso_2i")
      response.should have_selector("select#cancelacion_fecha_de_ingreso_1i")
      response.should have_selector("label", :content => "Medio de pago")
      response.should have_selector("select#cancelacion_medio_de_pago_id")
      response.should have_selector("label", :content => "Tipo de moneda")
      response.should have_selector("select#cancelacion_importe_currency")
      response.should have_selector("label", :content => "Importe")
      response.should have_selector("input#cancelacion_importe")
      response.should have_selector("label", :content => "Observaciones")
      response.should have_selector("input#cancelacion_observaciones")
    end

    describe "alta de cancelacion" do

      describe "exitoso" do
        before do
          @cotizacion_peso_dolar = Factory(:cotizacion_peso_dolar, :user => @user, :valor_cents => "467")
          @medios_de_pago = Factory(:medio_de_pago)
          fechaDeTransaccion = Time.zone.parse("17/05/2012 23:45")
          Time.stub!(:now).and_return(fechaDeTransaccion)
          visit new_partida_contable_cancelacion_path(@pc, @pc.cancelaciones.new)
          select "15"
          select "mayo"
          select "2012"
          select "Cheque", :from => :cancelacion_medio_de_pago_id
          select "ARS", :from => :cancelacion_importe_currency
          fill_in :cancelacion_importe, :with => 3
          fill_in :cancelacion_observaciones, :with => "esto es una prueba"
          click_button
        end

        it "debe mostrarse la cancelación ingresada" do
          response.should render_template('cancelaciones/index')
          response.should have_selector("td", :content => "17/05/2012 23:45")
          response.should have_selector("td", :content => "15/05/2012")
          response.should have_selector("td", :content => "Cheque")
          response.should have_selector("td", :content => "ARS")
          response.should have_selector("td", :content => "3")
          response.should have_selector("td", :content => "esto es una prueba")
          response.should have_selector("td", :content => "4,67")
        end

        it "la partida contable debe cambiar el estado a parcial cuando se ingresa una cancelación" do
          visit partidas_contable_path
          response.should have_selector("td", :content => "parcial")
        end

      end

      describe "fallido" do
        before do
          @cotizacion_peso_dolar = Factory(:cotizacion_peso_dolar, :user => @user)
          @cancelacion = Factory(:cancelacion, :partida_contable => @pc)
          fechaDeTransaccion = Time.zone.parse("17/05/2012 23:45")
          Time.stub!(:now).and_return(fechaDeTransaccion)
          visit new_partida_contable_cancelacion_path(@pc, @pc.cancelaciones.new)
          select "15"
          select "mayo"
          select "2012"
          select "Cheque", :from => :cancelacion_medio_de_pago_id
          select "ARS", :from => :cancelacion_importe_currency
          fill_in :cancelacion_importe, :with => "a"
          fill_in :cancelacion_observaciones, :with => "esto es una prueba"
          click_button
        end

        it "debe retornar a la vista de alta" do
          response.should render_template('cancelaciones/new')
          response.should have_selector("div#error_explanation")
        end
      end
    end

    describe "anulación" do
      it "link de anulación" do
        fechaDeTransaccion = "13/05/2012 22:41"
        @cancelacion = Factory(:cancelacion, :partida_contable => @pc, :created_at => Time.zone.parse(fechaDeTransaccion))
        visit partida_contable_cancelaciones_path(@pc)
        response.should have_selector("a", :href => partida_contable_cancelacion_path(@pc, @cancelacion), :content => "Anular")
        # click_link "Anular"
        # response.should render_template('cancelaciones/index')
        # @cancelacion.reload
        # @cancelacion.estado.should == "Anulada"
        # response.should_not have_selector("td", :content => "13/05/2012 22:41")
      end
    end

    describe "Cumplimiento de la partida contable" do
      it "debe cambiar el estado de " do
        fechaDeTransaccion = "13/05/2012 22:41"
        @cancelacion = Factory(:cancelacion, :partida_contable => @pc, :created_at => Time.zone.parse(fechaDeTransaccion))
        visit partida_contable_cancelaciones_path(@pc)
        response.should have_selector("a", :href => dar_por_cumplida_partida_contable_path(@pc), :content => "Dar por cumplida")
      end
    end

  end
end
