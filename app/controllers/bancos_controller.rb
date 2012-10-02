class BancosController < ApplicationController
  before_filter :encontrar_banco, :only => [:show, :edit, :update, :destroy]

  def index
    @bancos = Banco.all
    respond_with(@bancos)
  end

  def show
    # @banco = Banco.find(params[:id])
    respond_with(@banco)
  end

  def new
    @banco = Banco.new
    respond_with(@banco)
  end

  def edit
    # @banco = Banco.find(params[:id])
  end

  def create
    @banco = Banco.new(params[:banco])
    @banco.save
    respond_with(@banco)
  end

  def update
    # @banco = Banco.find(params[:id])
    @banco.update_attributes(params[:banco])
    respond_with(@banco)
  end

  def destroy
    # @banco = Banco.find(params[:id])
    @banco.destroy
    respond_with(@banco)
  end

  private

  def encontrar_banco
    @banco = Banco.find(params[:id])
  end
end
