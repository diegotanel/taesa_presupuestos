#encoding: utf-8

require 'spec_helper'

describe SaldoBancario do
  before(:each) do
    @user = Factory(:user)
    @attr = {:user_id => @user, :valor => 1356, :valor_currency => "EUR"}
  end

  it "con atributos válidos debe crear una nueva instancia" do
    SaldoBancario.create!(@attr)
  end

  describe "asociación con user" do

    before(:each) do
      @SaldoBancario = SaldoBancario.create(@attr)
    end

    it "should have a user attribute" do
      @SaldoBancario.should respond_to(:user)
    end

    it "should have a valor attribute" do
      @SaldoBancario.should respond_to(:valor)
    end

    it "should have a valor_cents attribute" do
      @SaldoBancario.should respond_to(:valor_cents)
    end

    it "should have a valor_currency attribute" do
      @SaldoBancario.should respond_to(:valor_currency)
    end

    it "should have the right associated user" do
      @SaldoBancario.user_id.should == @user.id
      @SaldoBancario.user.should == @user
    end

    it "valor es del tipo money" do
      @SaldoBancario.valor == Money.new(@attr[:valor], @attr[:valor_currency])
    end

    describe "validations" do

      it "should require a user id" do
        SaldoBancario.new(@attr.merge(:user_id => "")).should_not be_valid
      end

      # it "should require number content" do
      #   SaldoBancario.new(@attr.merge(:valor => "a")).should_not be_valid
      # end

      # it "should require number content" do
      #   SaldoBancario.new(@attr.merge(:valor_cents => "a")).should_not be_valid
      # end

      # it "should require non nil content" do
      #   SaldoBancario.new(@attr.merge(:valor => nil)).should_not be_valid
      # end

      # it "should require nonblank content" do
      #   SaldoBancario.new(@attr.merge(:valor => "")).should_not be_valid
      # end

      it "puede ser cero" do
        SaldoBancario.new(@attr.merge(:valor => 0)).should be_valid
      end

      it "puede ser cero con decimales" do
        SaldoBancario.new(@attr.merge(:valor => 0.00)).should be_valid
      end

      it "puede ser inferior a cero" do
        SaldoBancario.new(@attr.merge(:valor => "-0,01")).should be_valid
      end

      it "should require nonblank content" do
        SaldoBancario.new(@attr.merge(:valor_currency => "")).should_not be_valid
      end

    end


  end
end
