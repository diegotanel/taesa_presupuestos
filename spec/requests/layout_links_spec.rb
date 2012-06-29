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


  it "should have a Contact page at '/contact'" do
    get '/contact'
    response.should have_selector('title', :content => "Contact")
  end

  it "should have an About page at '/about'" do
    get '/about'
    response.should have_selector('title', :content => "About")
  end

  it "should have a Help page at '/help'" do
    get '/help'
    response.should have_selector('title', :content => "Help")
  end

  it "should have a signup page at '/signup'" do
    get '/signup'
    response.should have_selector('title', :content => "Sign up")
  end

  it "should have a signup page at '/signin'" do
    get '/signin'    
    response.should have_selector('title', :content => "Sign in")
  end

  it "Visito la pagina de Sign in" do
    visit signin_path
    response.should have_selector('title', :content => "Sign in")
  end

  it "should have the right links on the layout - About" do
    visit root_path
    click_link "About"
    response.should have_selector('title', :content => "About")
  end

  it "should have the right links on the layout - Help" do
    visit root_path
    click_link "Help"
    response.should have_selector('title', :content => "Help")
  end

  it "should have the right links on the layout - Contact" do
    visit root_path
    click_link "Contact"
    response.should have_selector('title', :content => "Contact")
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
      response.should have_selector("a", :href => signin_path, :content => "Sign in")
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
      flash.now[:error].should =~ /invalid/i
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

    it"should have a signout link" do
      visit root_path
      response.should have_selector("a", :href => signout_path, :content => "Sign out")
    end

    it "should have a profile link" do
      visit root_path
      response.should have_selector("a", :href => user_path(@user), :content => "Profile")
    end

    it "should have a settings link" do
      visit root_path
      response.should have_selector("a", :href => edit_user_path(@user), :content => "Settings")
    end

    it "should have a users link" do
      visit root_path
      response.should have_selector("a", :href => users_path, :content => "Users")
    end

  end
  DatabaseCleaner.clean
end
