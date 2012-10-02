class ProveedoresController < ApplicationController
  def index
    @proveedores = Proveedor.all
    respond_with(@proveedores)
  end

  def show
    @proveedor = Proveedor.find(params[:id])
    respond_with(@proveedor)
  end

  def new
    @proveedor = Proveedor.new
    respond_with(@proveedor)
  end

  def edit
    @proveedor = Proveedor.find(params[:id])
  end

  def create
    @proveedor = Proveedor.new(params[:proveedor])
    @proveedor.save
    respond_with(@proveedor)
  end

  def update
    @proveedor = Proveedor.find(params[:id])
    @proveedor.update_attributes(params[:proveedor])
    respond_with(@proveedor)
  end

  def destroy
    @proveedor = Proveedor.find(params[:id])
    @proveedor.destroy
    respond_with(@proveedor)
  end
end
