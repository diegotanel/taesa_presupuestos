#encoding: utf-8

require 'spec_helper'
require 'database_cleaner'
DatabaseCleaner.strategy = :truncation

describe "InformesPresupuestarios" do
  describe "como usuario" do
    before do
      @user = Factory(:user)
      @fecha = "25/09/2012 23:06"
      integration_sign_in(@user)
    end

    describe "vista indice" do
      it "link de generación de informes" do
        visit home_path
        etiqueta = "Informes Presupuestario"
        response.should have_selector("a", :href => informes_presupuestario_path, :content => etiqueta)
        click_link etiqueta
        response.should render_template('informes_presupuestario/index')
      end

      it "debe mostrar la lista de las empresas para generar el informe" do
        @empresa1 = Factory(:empresa, :detalle => "Calmin")
        @empresa2 = Factory(:empresa, :detalle => "TAESA")
        visit informes_presupuestario_path
        response.should have_selector("a", :href => informe_presupuestario_path(@empresa1), :content => @empresa1.detalle)
        response.should have_selector("a", :href => informe_presupuestario_path(@empresa2), :content => @empresa2.detalle)
      end

      describe "generar informe presupuestario" do
        before do
          @empresa = Factory(:empresa, :detalle => "Calmin")
          @banco = Factory(:banco, :detalle => "Banco Provincia Buenos Aires")
          fechaDeTransaccion = Time.zone.parse("17/05/2012 23:45")
          Time.stub!(:now).and_return(fechaDeTransaccion)
          @saldo_bancario = SaldoBancario.create!(:user_id => @user, :valor => 1, :valor => Money.new(250000, "ARS"), :empresa_id => @empresa, :banco_id => @banco)
          @pc1 = Factory(:partida_contable, :importe_cents => 40600000, :importe_currency => "ARS", :tipo_de_movimiento => PartidaContable::TIPODEMOVIMIENTO[:salida], :banco => nil, :empresa => @empresa, :detalle => "Ferrari Venta 1000 Tn Trigo")
          @pc2 = Factory(:partida_contable, :importe_cents => 14000000, :importe_currency => "ARS", :tipo_de_movimiento => PartidaContable::TIPODEMOVIMIENTO[:salida], :banco => @banco, :empresa => @empresa, :detalle => "Siembra soja")
          visit informes_presupuestario_path
          click_link "Calmin"
        end

        it "debe mostrar los encabezados y el link de imprimir" do
          response.should have_selector("h1", :content => "Calmin")
          response.should have_selector("th", :content => "Fecha")
          response.should have_selector("th", :content => "Detalle")
          response.should have_selector("th", :content => "Sin asignar banco")
          response.should have_selector("th", :content => "Banco Provincia Buenos Aires")
          response.should have_selector("td", :content => "Debe")
          response.should have_selector("td", :content => "Haber")
          response.should have_selector("td", :content => "Saldo")
          response.should have_selector("th", :content => "Saldo total financiero")
          response.should have_selector("a", :href => "#", :content => "Imprimir informe") 
        end

        it "debe mostrar la tabla con un banco" do
          response.should have_selector("td", :content => "17/05/2012 23:45")
          response.should have_selector("td", :content => @saldo_bancario.detalle)
          response.should have_selector("td", :content => "$2.500,00")
          response.should have_selector("td", :content => "$408.500,00")
          response.should have_selector("td", :content => "-$137.500,00")
          response.should have_selector("td", :content => "$268.500,00")
        end
      end
    end
  end
  DatabaseCleaner.clean
end
