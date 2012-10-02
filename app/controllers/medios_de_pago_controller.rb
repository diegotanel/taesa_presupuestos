class MediosDePagoController < ApplicationController
  def index
    @medios_de_pago = MedioDePago.all
    respond_with(@medios_de_pago)
  end

  def show
    @medio_de_pago = MedioDePago.find(params[:id])
    respond_with(@medio_de_pago)
  end

  def new
    @medio_de_pago = MedioDePago.new
    respond_with(@medio_de_pago)
  end

  def edit
    @medio_de_pago = MedioDePago.find(params[:id])
  end

  def create
    @medio_de_pago = MedioDePago.new(params[:medio_de_pago])
    @medio_de_pago.save
    respond_with(@medio_de_pago)
  end

  def update
    @medio_de_pago = MedioDePago.find(params[:id])
    @medio_de_pago.update_attributes(params[:medio_de_pago])
    respond_with(@medio_de_pago)
  end

  def destroy
    @medio_de_pago = MedioDePago.find(params[:id])
    @medio_de_pago.destroy
    respond_with(@medio_de_pago)
  end
end
