class ClientesProveedoresController < ApplicationController
  def index
    @clientes_proveedores = ClienteProveedor.all
    respond_with(@clientes_proveedores)
  end

  def show
    @cliente_proveedor = ClienteProveedor.find(params[:id])
    respond_with(@cliente_proveedor)
  end

  def new
    @cliente_proveedor = ClienteProveedor.new
    respond_with(@cliente_proveedor)
  end

  def edit
    @cliente_proveedor = ClienteProveedor.find(params[:id])
  end

  def create
    @cliente_proveedor = ClienteProveedor.new(params[:cliente_proveedor])
    @cliente_proveedor.save
    respond_with(@cliente_proveedor)
  end

  def update
    @cliente_proveedor = ClienteProveedor.find(params[:id])
    @cliente_proveedor.update_attributes(params[:cliente_proveedor])
    respond_with(@cliente_proveedor)
  end

  def destroy
    @cliente_proveedor = ClienteProveedor.find(params[:id])
    @cliente_proveedor.destroy
    respond_with(@cliente_proveedor)
  end
end
