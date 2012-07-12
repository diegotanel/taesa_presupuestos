#encoding: utf-8

class SessionsController < ApplicationController
  before_filter :deny_for_signed_users, :only => [:new, :create]
  
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

  private

  def deny_for_signed_users
    redirect_to(user_path(current_user)) if signed_in?
  end

end
