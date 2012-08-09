class UsersController < ApplicationController
  before_filter :signed_in_user,             :only => [:index, :new, :create, :edit, :update, :destroy, :show]
  before_filter :correct_user_administrator, :only => [:edit, :update]
  # before_filter :correct_user,               :only => :update
  before_filter :admin_user,                 :only => [:new, :create, :destroy]
  before_filter :deny_for_same_user,         :only => :destroy

  def index
    @title = "Usuarios"
    @users = User.paginate(:page => params[:page])
  end

  def show
    @user = User.find(params[:id])
    @title = @user.name 
  end

  def new
    @user = User.new
    @title = "Alta de usuario"
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      #      sign_in @user
      #      flash[:success] = "Bienvenido al sistema de presupuestos"
      #      redirect_to @user
      redirect_to users_path
    else
      @title = "Alta de usuario"
      @user.password = ""
      @user.password_confirmation = ""
      render 'new'
    end
  end

  def edit
    @title = "Editar usuario"
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Perfil actualizado"
      redirect_to @user
    else
      @title = "Editar usuario"
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    flash[:success] = "Usuario eliminado"
    redirect_to users_path 
  end

  private

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end

  def correct_user_administrator
    @user = User.find(params[:id])
    unless current_user.admin?
      redirect_to(root_path) unless current_user?(@user)
    end
  end

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end

  def deny_for_same_user
    @user = User.find(params[:id])
    redirect_to users_path if current_user?(@user) 
  end

end
