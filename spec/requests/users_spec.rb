#encoding: utf-8

require 'spec_helper'
require 'database_cleaner'
DatabaseCleaner.strategy = :truncation

describe "Users" do
  describe "signup" do

    before(:each) do
      @user = Factory(:user)
      integration_sign_in(@user)
    end

    it "verificar si el formulario contiene los campos correspondientes" do
      visit signup_path
      response.should render_template('users/new')
      response.should have_selector("input#user_name")
      response.should have_selector("input#user_email")
      response.should have_selector("input#user_password")
      response.should have_selector("input#user_password_confirmation")
      response.should have_selector("input", :type => "submit")
    end

    it "el boton de submit tiene que tener la etiqueta correcta" do
      visit signup_path
      response.should have_selector("input", :type => "submit", :value => "Alta" )
    end

    it "Borrar los campos de password cuando se genera un error" do
      visit signup_path
      fill_in :user_name,                  :with => "fruta"
      fill_in :user_email,                 :with => "fruta@frutamail"
      fill_in :user_password,              :with => "foobar"
      fill_in :user_password_confirmation, :with => "foobar"
      click_button
      response.should have_selector('input#user_password', :content => "")
      response.should have_selector('input#user_password_confirmation', :content => "")
    end

    describe "failure" do
      it "should not make a new user" do
        lambda do
          visit signup_path
          fill_in :user_name,                  :with => ""
          fill_in :user_email,                 :with => ""
          fill_in :user_password,              :with => ""
          fill_in :user_password_confirmation, :with => ""
          click_button
          response.should have_selector("div#error_explanation")
          response.should render_template('users/new')
        end.should_not change(User, :count)
      end
    end

    describe "success" do
      it "should make a new user" do
        lambda do
          visit signup_path
          fill_in :user_name,                  :with => "Example User"
          fill_in :user_email,                 :with => "user@example.com"
          fill_in :user_password,              :with => "foobar"
          fill_in :user_password_confirmation, :with => "foobar"
          click_button
          #          response.should have_selector("div.flash.success", :content => "Bienvenido")
          #          response.should render_template('users/show')
          response.should render_template('users/index')
        end.should change(User, :count).by(1)
        DatabaseCleaner.clean
      end
    end
  end

  describe "sign in/out" do

    describe "failure" do
      it "should not sign a user in" do
        visit signin_path
        fill_in :email,    :with => ""
        fill_in :session_password, :with => ""
        click_button
        response.should have_selector("div.flash.error", :content => "no válida")
      end
    end

    describe "success" do

      before(:each) do
        @user = Factory(:user)
        integration_sign_in(@user)
      end

      it "should sign a user in and out" do
        controller.should be_signed_in
        click_link "Cerrar sesión"
        controller.should_not be_signed_in
      end

      it "el boton de submit tiene que tener la etiqueta correcta" do
        visit edit_user_path(@user)
        response.should have_selector("input", :type => "submit", :value => "Actualizar" )
      end

    end
  end

  describe "index users" do
    it "debe mostrar los usuarios" do
      @admin = integration_sign_in(Factory(:user, :email => "admin@example.com", :admin => true))
      @second = Factory(:user, :name => "Bob", :email => "another@example.com")
      @third  = Factory(:user, :name => "Ben", :email => "another@example.net")
      visit users_path
      response.should have_selector("ul") do |n|
        n.should have_selector("li", :content => "#{@admin[:name]}")
        n.should have_selector("li", :content => "#{@second[:name]}")
        n.should have_selector("li", :content => "#{@third[:name]}")
      end
    end

    it "debe haber tres usuarios" do
      @admin = integration_sign_in(Factory(:user, :email => "admin@example.com", :admin => true))
      @second = Factory(:user, :name => "Bob", :email => "another@example.com")
      @third  = Factory(:user, :name => "Ben", :email => "another@example.net")
      @users = [@admin, @second, @third]
      visit users_path
      response.should have_selector("ul.users li", :count => @users.length)
    end
  end

  describe "delete user" do

    #    it "debe borrar al usuario elegido" do
    #      admin = integration_sign_in(Factory(:user, :email => "admin@example.com", :admin => true))
    #      second = Factory(:user, :name => "Bob", :email => "another@example.com")
    #      third  = Factory(:user, :name => "Ben", :email => "another@example.net")
    #      visit users_path

    #      click_link "delete_2"
    #      click_button
    #      visit

    #    end
  end

end
DatabaseCleaner.clean
