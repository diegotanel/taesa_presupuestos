class InformesPresupuestarioController < ApplicationController
  def index
    @empresas = Empresa.all
    respond_with(@empresas)
  end

  def show
    @empresa = Empresa.find(params[:id])
    @reporte = InformePresupuestario.new.generar(@empresa)
    respond_with(@reporte, @empresa)
  end
end
