class ClientesController < ApplicationController
  def index
    @clientes = Cliente.all
    respond_with(@clientes)
  end

  def show
    @cliente = Cliente.find(params[:id])
    respond_with(@cliente)
  end

  def new
    @cliente = Cliente.new
    respond_with(@cliente)
  end

  def edit
    @cliente = Cliente.find(params[:id])
  end

  def create
    @cliente = Cliente.new(params[:cliente])
    @cliente.save
    respond_with(@cliente)
  end

  def update
    @cliente = Cliente.find(params[:id])
    @cliente.update_attributes(params[:cliente])
    respond_with(@cliente)
  end

  def destroy
    @cliente = Cliente.find(params[:id])
    @cliente.destroy
    respond_with(@cliente)
  end
end
