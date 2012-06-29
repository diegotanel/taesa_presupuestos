require 'spec_helper'

describe UsersController do
  render_views

  describe "GET 'index'" do

    describe "for non-signed-in users" do
      it "should deny access" do
        get :index
        response.should redirect_to(signin_path)
        flash[:notice].should =~ /sign in/i
      end
    end

    describe "for signed-in users" do

      before(:each) do
        @user = test_sign_in(Factory(:user))
        second = Factory(:user, :name => "Bob", :email => "another@example.com")
        third  = Factory(:user, :name => "Ben", :email => "another@example.net")

        @users = [@user, second, third]
      end

      it "should be successful" do
        get :index
        response.should be_success
      end

      it "should have the right title" do
        get :index
        response.should have_selector("title", :content => "All users")
      end

      it "should have an element for each user" do
        get :index
        @users.each do |user|
          response.should have_selector("li", :content => user.name)
        end
      end

      it "no debe contener un link de delete por cada usuario" do
        get :index
        @users.each do |user|
          response.should_not have_selector("li", :content => "delete")
        end
      end

      it "debe contener un link de delete por cada usuario" do
        @user.toggle!(:admin)
        get :index
        @users.each do |user|
          response.should have_selector("li", :content => "delete")
        end
      end
    end
  end

  describe "GET 'new'" do
    it "should be successful" do
      get :new
      response.should be_success
    end

    it "should have the right title" do
      get :new
      response.should have_selector("title", :content => "Sign up")
    end

    it "verificar si el formulario contiene los campos correspondientes" do
      get :new
      response.should have_selector("input#user_name")
      response.should have_selector("input#user_email")
      response.should have_selector("input#user_password")
      response.should have_selector("input#user_password_confirmation")
    end

    it "no debe poder acceder en caso de que este logueado" do
      @user = test_sign_in(Factory(:user))
      get :new
      response.should redirect_to(user_path(@user))
    end

  end

  describe "GET 'show'" do

    before(:each) do
      @user = Factory(:user)
    end

    describe "as a non-signed-in user" do
      it "should deny access" do
        get :show, :id => @user
        response.should redirect_to(signin_path)
      end
    end

    describe "as a signed-in user" do
      before(:each) do
        test_sign_in(@user)
      end

      it "should be successful" do
        get :show, :id => @user
        response.should be_success
      end

      it "should find the right user" do
        get :show, :id => @user
        assigns(:user).should == @user
      end

      it "should have the right title" do
        get :show, :id => @user
        response.should have_selector("title", :content => @user.name)
      end

      it "should include the user's name" do
        get :show, :id => @user
        response.should have_selector("h1", :content => @user.name)
      end

      it "should have a profile image" do
        get :show, :id => @user
        response.should have_selector("h1>img", :class => "gravatar")
      end

      it "should show the user's microposts" do
        mp1 = Factory(:micropost, :user => @user, :content => "Foo bar")
        mp2 = Factory(:micropost, :user => @user, :content => "Baz quux")
        get :show, :id => @user
        response.should have_selector("span.content", :content => mp1.content)
        response.should have_selector("span.content", :content => mp2.content)
      end
    end
  end

  describe "POST 'create'" do
    describe "failure" do
      before(:each) do
        @attr = {:name => "", :email => "", :password => "", :password_confirmation => ""}
      end

      it "El usuario no es valido si los datos estan en blanco" do
        post :create, :user => @attr
        assigns(:user).should_not be_valid
      end

      it "Los datos del usuario deben estar en blanco" do
        post :create, :user => @attr
        @user = assigns(:user)
        @user.name.should == @attr[:name]
        @user.email.should == @attr[:email]
        @user.password.should == @attr[:password]
        @user.password_confirmation.should == @attr[:password_confirmation]
      end

      it "Se deben quedar en blanco los campos passwords" do
        @attr2 = {:name => "diego", :email => "fruta@fruta", :password => "foo", :password_confirmation => "foo"}      
        post :create, :user => @attr2
        @user = assigns(:user)
        @user.password.should be_blank
        @user.password_confirmation.should be_blank
      end

      it "should not create a user" do
        lambda do
          post :create, :user => @attr
        end.should_not change(User, :count)
      end

      it "shoud have the right title" do
        post :create, :user => @attr
        response.should have_selector("title", :content => "Sign up")
      end

      it "should render the 'new' page" do
        post :create, :user => @attr
        response.should render_template('new')
      end
    end

    describe "success" do

      before(:each) do
        @attr = { :name => "New User", :email => "user@example.com",
                  :password => "foobar", :password_confirmation => "foobar" }
      end

      it "should create a user" do
        lambda do
          post :create, :user => @attr
        end.should change(User, :count).by(1)
      end

      it "should redirect to the user show page" do
        post :create, :user => @attr
        response.should redirect_to(user_path(assigns(:user)))
      end   

      it "should have a welcome message" do
        post :create, :user => @attr
        flash[:success].should =~ /welcome to the sample app/i
      end

      it "should sign the user in" do
        post :create, :user => @attr
        controller.should be_signed_in
      end

      it "no debe poder acceder en caso de que este logueado" do
        @user = test_sign_in(Factory(:user))
        post :create, :user => @attr
        response.should redirect_to(user_path(@user))
      end

      describe "admin attribute" do

        before(:each) do
          @user = User.create!(@attr)
        end

        it "should respond to admin" do
          @user.should respond_to(:admin)
        end

        it "should not be an admin by default" do
          @user.should_not be_admin
        end

        it "should be convertible to an admin" do
          @user.toggle!(:admin)
          @user.should be_admin
        end
      end
    end
  end 

  describe "GET 'edit'" do

    before(:each) do
      @user = Factory(:user)
      test_sign_in(@user)
    end

    it "El usuario debe estar logueado" do
      controller.should be_signed_in
    end

    it "el nombre del usuario logueado debe ser Michael Hart" do
      controller.current_user.name.should == "Michael Hartl"
    end

    it "el usuario logueado debe ser Michale Hart" do
      controller.current_user?(@user).should == true
    end

    it "should be successful" do
      get :edit, :id => @user
      response.should be_success
    end

    it "should have the right title" do
      get :edit, :id => @user
      response.should have_selector("title", :content => "Edit user")
    end

    it "should have a link to change the Gravatar" do
      get :edit, :id => @user
      gravatar_url = "http://gravatar.com/emails"
      response.should have_selector("a", :href => gravatar_url, :content => "change")
    end
  end

  describe "PUT 'update'" do

    before(:each) do
      @user = Factory(:user)
      test_sign_in(@user)
    end

    describe "failure" do

      before(:each) do
        @attr = { :email => "", :name => "", :password => "", :password_confirmation => "" }
      end

      it "should render the 'edit' page" do
        put :update, :id => @user, :user => @attr
        response.should render_template('edit')
      end

      it "should have the right title" do
        put :update, :id => @user, :user => @attr
        response.should have_selector("title", :content => "Edit user")
      end
    end

    describe "success" do

      before(:each) do
        @attr = { :name => "New Name", :email => "user@example.org", :password => "barbaz", :password_confirmation => "barbaz" }
      end

      it "should change the user's attributes" do
        put :update, :id => @user, :user => @attr
        @user.reload
        @user.name.should  == @attr[:name]
        @user.email.should == @attr[:email]
      end

      it "should redirect to the user show page" do
        put :update, :id => @user, :user => @attr
        response.should redirect_to(user_path(@user))
      end

      it "should have a flash message" do
        put :update, :id => @user, :user => @attr
        flash[:success].should =~ /updated/
      end
    end
  end

  describe "authentication of edit/update pages" do

    before(:each) do
      @user = Factory(:user)
    end

    describe "for non-signed-in users" do

      it "should deny access to 'edit'" do
        get :edit, :id => @user
        response.should redirect_to(signin_path)
      end

      it "should deny access to 'update'" do
        put :update, :id => @user, :user => {}
        response.should redirect_to(signin_path)
      end
    end

    describe "for signed-in users" do

      before(:each) do
        wrong_user = Factory(:user, :email => "user@example.net")
        test_sign_in(wrong_user)
      end

      it "should require matching users for 'edit'" do
        get :edit, :id => @user
        response.should redirect_to(root_path)
      end

      it "should require matching users for 'update'" do
        put :update, :id => @user, :user => {}
        response.should redirect_to(root_path)
      end

    end

  end

  describe "DELETE 'destroy'" do

    before(:each) do
      @user = Factory(:user)
    end

    describe "as a non-signed-in user" do
      it "should deny access" do
        delete :destroy, :id => @user
        response.should redirect_to(signin_path)
      end
    end

    describe "as a non-admin user" do
      it "should protect the page" do
        test_sign_in(@user)
        delete :destroy, :id => @user
        response.should redirect_to(root_path)
      end
    end

    describe "as an admin user" do

      before(:each) do
        @admin = Factory(:user, :email => "admin@example.com", :admin => true)
        test_sign_in(@admin)
      end

      it "should destroy the user" do
        lambda do
          delete :destroy, :id => @user
        end.should change(User, :count).by(-1)
      end

      it "should redirect to the users page" do
        delete :destroy, :id => @user
        response.should redirect_to(users_path)
      end

      it "no puede destruirse a si mismo" do
        lambda do
          post :destroy, :id => @admin
        end.should_not change(User, :count)
      end
    end
  end
end
