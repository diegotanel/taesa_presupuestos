#encoding: utf-8

class SaldosBancarioController < ApplicationController
  before_filter :encontrar_saldo

  def edit
    inicializacionVista
  end

  def update
    inicializacionVista
    if params[:saldo_bancario].any?
      params[:saldo_bancario][:user_id] = current_user.id
      @saldo_bancario.update_attributes(params[:saldo_bancario])
    end
    respond_with(@saldo_bancario, :location => edit_saldo_bancario_path)
  end

  private

  def encontrar_saldo
    @saldo_bancario = SaldoBancario.find(params[:id])
  end

  def inicializacionVista
    @valorVista = @saldo_bancario.valor
    @actualizacionVista = @saldo_bancario.updated_at
    @usuarioVista = @saldo_bancario.user.name
  end

end
