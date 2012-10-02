class ProductosTrabajosController < ApplicationController
  def index
    @productos_trabajos = ProductoTrabajo.all
    respond_with(@productos_trabajos)
  end

  def show
    @producto_trabajo = ProductoTrabajo.find(params[:id])
    respond_with(@producto_trabajo)
  end

  def new
    @producto_trabajo = ProductoTrabajo.new
    respond_with(@producto_trabajo)
  end

  def edit
    @producto_trabajo = ProductoTrabajo.find(params[:id])
  end

  def create
    @producto_trabajo = ProductoTrabajo.new(params[:producto_trabajo])
    @producto_trabajo.save
    respond_with(@producto_trabajo)
  end

  def update
    @producto_trabajo = ProductoTrabajo.find(params[:id])
    @producto_trabajo.update_attributes(params[:producto_trabajo])
    respond_with(@producto_trabajo)
  end

  def destroy
    @producto_trabajo = ProductoTrabajo.find(params[:id])
    @producto_trabajo.destroy
    respond_with(@producto_trabajo)
  end
end
