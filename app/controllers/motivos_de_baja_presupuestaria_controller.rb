class MotivosDeBajaPresupuestariaController < ApplicationController
  def index
    @motivos_de_baja_presupuestaria = MotivoDeBajaPresupuestaria.all
    respond_with(@motivos_de_baja_presupuestaria)
  end

  def show
    @motivo_de_baja_presupuestaria = MotivoDeBajaPresupuestaria.find(params[:id])
    respond_with(@motivo_de_baja_presupuestaria)
  end

  def new
    @motivo_de_baja_presupuestaria = MotivoDeBajaPresupuestaria.new
    respond_with(@motivo_de_baja_presupuestaria)
  end

  def edit
    @motivo_de_baja_presupuestaria = MotivoDeBajaPresupuestaria.find(params[:id])
  end

  def create
    @motivo_de_baja_presupuestaria = MotivoDeBajaPresupuestaria.new(params[:motivo_de_baja_presupuestaria])
    @motivo_de_baja_presupuestaria.save
    respond_with(@motivo_de_baja_presupuestaria)
  end

  def update
    @motivo_de_baja_presupuestaria = MotivoDeBajaPresupuestaria.find(params[:id])
    @motivo_de_baja_presupuestaria.update_attributes(params[:motivo_de_baja_presupuestaria])
    respond_with(@motivo_de_baja_presupuestaria)
  end

  def destroy
    @motivo_de_baja_presupuestaria = MotivoDeBajaPresupuestaria.find(params[:id])
    @motivo_de_baja_presupuestaria.destroy
    respond_with(@motivo_de_baja_presupuestaria)
  end
end
