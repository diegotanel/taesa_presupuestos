class PagesController < ApplicationController
  def home
    @title = "Home"
    @cotizacion_peso_dolar = CotizacionPesoDolar.first
    @saldo_bancario = SaldoBancario.first
  end

end
