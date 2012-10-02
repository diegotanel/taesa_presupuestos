#encoding: utf-8

class CotizacionesPesoDolarController < ApplicationController
  before_filter :encontrar_cotizacion

  def edit
    inicializacionVista
  end

  def update
    inicializacionVista
    if params[:cotizacion_peso_dolar].any?
      params[:cotizacion_peso_dolar][:user_id] = current_user.id
      @cotizacion_peso_dolar.update_attributes(params[:cotizacion_peso_dolar])
    end
    respond_with(@cotizacion_peso_dolar, :location => edit_cotizacion_peso_dolar_path)
  end

  private

  def encontrar_cotizacion
    @cotizacion_peso_dolar = CotizacionPesoDolar.find(params[:id])
  end

  def inicializacionVista
    @valorVista = @cotizacion_peso_dolar.valor
    @actualizacionVista = @cotizacion_peso_dolar.updated_at
    @usuarioVista = @cotizacion_peso_dolar.user.name
  end

end
