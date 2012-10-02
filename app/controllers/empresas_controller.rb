class EmpresasController < ApplicationController
  def index
    @empresas = Empresa.all
    respond_with(@empresas)
  end

  def show
    @empresa = Empresa.find(params[:id])
    respond_with(@empresa)
  end

  def new
    @empresa = Empresa.new
    respond_with(@empresa)
  end

  def edit
    @empresa = Empresa.find(params[:id])
  end

  def create
    @empresa = Empresa.new(params[:empresa])
    @empresa.save
    respond_with(@empresa)
  end

  def update
    @empresa = Empresa.find(params[:id])
    @empresa.update_attributes(params[:empresa])
    respond_with(@empresa)
  end

  def destroy
    @empresa = Empresa.find(params[:id])
    @empresa.destroy
    respond_with(@empresa)
  end
end
