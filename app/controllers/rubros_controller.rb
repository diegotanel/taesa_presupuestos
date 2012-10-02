class RubrosController < ApplicationController
  def index
    @rubros = Rubro.all
    respond_with(@rubros)
  end

  def show
    @rubro = Rubro.find(params[:id])
    respond_with(@rubro)
  end

  def new
    @rubro = Rubro.new
    respond_with(@rubro)
  end

  def edit
    @rubro = Rubro.find(params[:id])
  end

  def create
    @rubro = Rubro.new(params[:rubro])
    @rubro.save
    respond_with(@rubro)
  end

  def update
    @rubro = Rubro.find(params[:id])
    @rubro.update_attributes(params[:rubro])
    respond_with(@rubro)
  end

  def destroy
    @rubro = Rubro.find(params[:id])
    @rubro.destroy
    respond_with(@rubro)
  end
end
