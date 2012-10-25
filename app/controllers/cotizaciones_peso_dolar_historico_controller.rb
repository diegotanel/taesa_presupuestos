class CotizacionesPesoDolarHistoricoController < ApplicationController
  def index
    @cotizaciones_peso_dolar_historico = CotizacionPesoDolarHistorico.all
    respond_with(@cotizaciones_peso_dolar_historico)
  end
end
