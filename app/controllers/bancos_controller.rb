class BancosController < ApplicationController
  before_filter :encontrar_banco, :only => [:show, :edit, :update, :destroy]

  def index
    @bancos = Banco.all
    respond_with(@bancos)
  end

  def show
    respond_with(@banco)
  end

  def new
    @banco = Banco.new
    respond_with(@banco)
  end

  def edit
  end

  def create
    params[:banco][:current_user_id] = current_user.id
    @banco = Banco.create(params[:banco])
    respond_with(@banco)
  end

  def update
    @banco.update_attributes(params[:banco])
    respond_with(@banco)
  end

  def destroy
    @banco.destroy
    respond_with(@banco)
  end

  private

  def encontrar_banco
    @banco = Banco.find(params[:id])
  end
end
