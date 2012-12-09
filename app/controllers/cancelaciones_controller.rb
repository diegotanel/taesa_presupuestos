#encoding: utf-8

class CancelacionesController < ApplicationController
  def index
    @pc = PartidaContable.find_by_id(params[:partida_contable_id])
    @cancelaciones = @pc.cancelaciones_activas
  end

  def new
    @pc = PartidaContable.find_by_id(params[:partida_contable_id])
    @cancelacion = @pc.cancelaciones.build
    @medios_de_pago = MedioDePago.all
  end

  def create
    @pc = PartidaContable.find_by_id(params[:partida_contable_id])
    @cancelacion = @pc.cancelaciones.build(params[:cancelacion])
    @pc.estado = PartidaContable::ESTADOS[:parcial]
    if @pc.save
      redirect_to partida_contable_cancelaciones_path(@pc)
    else
      @medios_de_pago = MedioDePago.all
      render 'new'
    end
  end

  def destroy
    @pc = PartidaContable.find_by_id(params[:partida_contable_id])
    @pc.cancelaciones.destroy(params[:id])
    if @pc.save
      flash[:success] = "La cacelación se anulo correctamente"
      redirect_to partida_contable_cancelaciones_path(@pc)
    else
      flash.now[:failure] = "La cancelación no pudo ser anulada"
      render 'index'
    end
  end
end
