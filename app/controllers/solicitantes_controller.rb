class SolicitantesController < ApplicationController
  def index
    @solicitantes = Solicitante.all
    respond_with(@solicitantes)
  end

  def show
    @solicitante = Solicitante.find(params[:id])
    respond_with(@solicitante)
  end

  def new
    @solicitante = Solicitante.new
    respond_with(@solicitante)
  end

  def edit
    @solicitante = Solicitante.find(params[:id])
  end

  def create
    @solicitante = Solicitante.new(params[:solicitante])
    @solicitante.save
    respond_with(@solicitante)
  end

  def update
    @solicitante = Solicitante.find(params[:id])
    @solicitante.update_attributes(params[:solicitante])
    respond_with(@solicitante)
  end

  def destroy
    @solicitante = Solicitante.find(params[:id])
    @solicitante.destroy
    respond_with(@solicitante)
  end
end
