require 'spec_helper'

describe User do

  before(:each) do
    @attr = {
      :name => "Example User",
      :email => "user@example.com",
      :password => "foobar",
      :password_confirmation => "foobar"
    }
  end

  it "should create a new instance given valid attributes" do
    User.create!(@attr)
  end

  it "should require a name" do
    no_name_user = User.new(@attr.merge(:name => ""))
    no_name_user.should_not be_valid
  end

  it "should require a email" do
    no_email_user = User.new(@attr.merge(:email => ""))
    no_email_user.should_not be_valid
  end

  it "should reject names that are too long" do
    long_name = "a" * 51
    long_name_user = User.new(@attr.merge(:name => long_name))
    long_name_user.should_not be_valid
  end

  it "should accept valid email addresses" do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      valid_email_user = User.new(@attr.merge(:email => address))
      valid_email_user.should be_valid
    end
  end

  it "should reject invalid email addresses" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    addresses.each do |address|
      invalid_email_user = User.new(@attr.merge(:email => address))
      invalid_email_user.should_not be_valid
    end
  end

  it "should reject duplicate email addresses" do
    User.create! @attr
    user_with_duplicate_email = User.new @attr
    user_with_duplicate_email.should_not be_valid
  end

  it "should reject email addresses identical up to case" do
    upcased_email = @attr[:email].upcase

    User.create!(@attr.merge(:email => upcased_email))
    user_with_duplicate_email = User.new @attr
    user_with_duplicate_email.should_not be_valid
  end

  it "should require a password" do
    User.new(@attr.merge(:password => "", :password_confirmation => "")).
      should_not be_valid
  end

  it "should require a matching password confirmation" do
    User.new(@attr.merge(:password_confirmation => "invalid")).
      should_not be_valid
  end

  it "should reject short password" do
    short = "a" * 5
    hash = @attr.merge(:password => short, :password_confirmation => short)
    User.new(hash).should_not be_valid
  end

  it "should reject long password" do
    long = "a" * 41
    hash = @attr.merge(:password => long, :password_confirmation => long)
    User.new(hash).should_not be_valid
  end

  describe "password encryption" do

    before(:each) do
      @user = User.create!(@attr)
    end

    it "should have an name attribute" do
      @user.should respond_to(:name)
    end

    it "should have an email attribute" do
      @user.should respond_to(:email)
    end

    it "should have an password attribute" do
      @user.should respond_to(:password)
    end

    it "should have an password_confirmation attribute" do
      @user.should respond_to(:password_confirmation)
    end

    it "should have an password digest attribute" do
      @user.should respond_to(:password_digest)
    end

    it "should have an remember token attribute" do
      @user.should respond_to(:remember_token)
    end

    it "should set the password digest" do
      @user.password_digest.should_not be_blank
    end

    describe "authenticate method" do

      it "should have an instance authenticate method" do
        @user.should respond_to(:authenticate)
      end

      it "should return nil on email/password mismatch" do
        wrong_password_user = @user.authenticate("wrongpass")
        wrong_password_user.should be_false
      end

      it "should return the user on email/password match" do
        matching_user = @user.authenticate(@attr[:password])
        matching_user.should == @user
      end
    end

    describe "remember token" do
      it "should set the remember_token" do
        @user.remember_token.should_not be_blank
      end
    end
  end
end
# == Schema Information
#
# Table name: users
#
#  id                 :integer         not null, primary key
#  name               :string(255)
#  email              :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  encrypted_password :string(255)
#  salt               :string(255)
#

