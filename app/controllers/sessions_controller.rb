#encoding: utf-8

class SessionsController < ApplicationController
  def new
    @title = "Ingresar"
  end

  def create
    @email = params[:session][:email]
    @password = params[:session][:password]
    user = User.find_by_email(@email)
    if user && user.authenticate(@password)
      sign_in user
      redirect_back_or user
    else
      @title = "Ingresar"
      flash.now[:error] = 'Combinación de email o contraseña no válida'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end

end
