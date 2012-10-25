class SaldosBancarioHistoricoController < ApplicationController
  def index
    @saldos_bancario_historico = SaldoBancarioHistorico.all
    respond_with(@saldos_bancario_historico)
  end
end
