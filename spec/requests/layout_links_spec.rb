#encoding: utf-8

require 'spec_helper'
require 'database_cleaner'
DatabaseCleaner.strategy = :truncation

describe "LayoutLinks" do

  it "should have a Home page at '/'" do
    get '/'
    response.should have_selector('title', :content => "Home")
  end

  it "tiene que redireccionarse a la pagina raiz" do
    visit root_path
    response.should render_template('/')
  end

  it "tiene que redireccionarse a la pagina raiz sin errores" do
    visit root_path
    response.should be_success
  end

  it "should have a signup page at '/signup'" do
    get '/signup'
    response.should have_selector('title', :content => "Alta de usuario")
  end

  it "should have a signup page at '/signin'" do
    get '/signin'    
    response.should have_selector('title', :content => "Ingresar")
  end

  it "Visito la pagina de Sign in" do
    visit signin_path
    response.should have_selector('title', :content => "Ingresar")
  end

  it "should have the right links on the layout - Home" do
    visit root_path
    click_link "Home"
    response.should have_selector('title', :content => "Home")
  end

  it "should have the right links on the layout - Sign up now!" do
    visit root_path
    click_link "Sign up now!"
    response.should # fill in
  end

  describe "when not signed in" do
    it "should have a signin link" do
      visit root_path
      response.should have_selector("a", :href => signin_path, :content => "Ingresar")
    end
  end

  describe "Cuando se quiere ingresar a la aplicacion pero con datos erroneos" do
    before(:each) do
      integration_sign_in_erroneo
    end

    it "se debe enviar los datos y comprobar que llegan" do
      response.should have_selector('pre', :content => "fruta@fruta.com")
      response.should have_selector('pre', :content => "foo")
    end

    it "se debe retornar formulario de ingreso " do
      response.should render_template('new')
    end

    it "should have a flash.now message" do
      flash.now[:error].should =~ /no válida/i
    end
  end

  describe "when signed in" do

    before(:each) do
      @user = Factory(:user)
      integration_sign_in(@user)
    end

    it "tiene que redireccionarse a la pagina con los perfiles del usuario" do
      visit user_path(@user)
      response.should render_template('users/show')
    end

    it "tiene que redireccionarse a la pagina con los seteos del usuario" do
      visit edit_user_path(@user)
      response.should render_template('users/edit')
    end

    it "direccion de la pagina con el perfil del usuario" do
      user_path(@user).should == "/users/#{User.first.id}"
    end

    it "El usuario debe haberse almacenado en el sistema" do
      User.first.name.should == @user.name
    end

    it "debe tener el nombre de la persona cuando voy al perfil" do
      visit user_path(@user)
      response.should have_selector('title', :content => @user.name)
    end

#    "Esto no funciona en el integration test por que el paso final al loguearse es un get al perfil del usuario"
#    it "Se debe direccionar a la pagina del usuario especifico" do
#      response.should redirect_to('sessions')
#    end

    it "debe estar logueado" do
      controller.should be_signed_in
    end

    it"should have a cerrar_sesión link" do
      visit root_path
      response.should have_selector("a", :href => signout_path, :content => "Cerrar sesión")
    end

    it "should have a perfil link" do
      visit root_path
      response.should have_selector("a", :href => user_path(@user), :content => "Perfil")
    end

    it "should have a seteos link" do
      visit root_path
      response.should have_selector("a", :href => edit_user_path(@user), :content => "Seteos")
    end

    it "should have a usuarios link" do
      visit root_path
      response.should have_selector("a", :href => users_path, :content => "Usuarios")
    end

  end
  DatabaseCleaner.clean
end
