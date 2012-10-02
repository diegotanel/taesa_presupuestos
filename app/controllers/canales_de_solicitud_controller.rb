class CanalesDeSolicitudController < ApplicationController
  def index
    @canales_de_solicitud = CanalDeSolicitud.all
    respond_with(@canales_de_solicitud)
  end

  def show
    @canal_de_solicitud = CanalDeSolicitud.find(params[:id])
    respond_with(@canal_de_solicitud)
  end

  def new
    @canal_de_solicitud = CanalDeSolicitud.new
    respond_with(@canal_de_solicitud)
  end

  def edit
    @canal_de_solicitud = CanalDeSolicitud.find(params[:id])
  end

  def create
    @canal_de_solicitud = CanalDeSolicitud.new(params[:canal_de_solicitud])
    @canal_de_solicitud.save
    respond_with(@canal_de_solicitud)
  end

  def update
    @canal_de_solicitud = CanalDeSolicitud.find(params[:id])
    @canal_de_solicitud.update_attributes(params[:canal_de_solicitud])
    respond_with(@canal_de_solicitud)
  end

  def destroy
    @canal_de_solicitud = CanalDeSolicitud.find(params[:id])
    @canal_de_solicitud.destroy
    respond_with(@canal_de_solicitud)
  end
end
