require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe SaldosBancarioController do

  # This should return the minimal set of attributes required to create a valid
  # SaldoBancario. As you add validations to SaldoBancario, be sure to
  # update the return value of this method accordingly.

  before do
    @user = Factory(:user)
    test_sign_in(@user)
    @saldo_bancario = SaldoBancario.create! valid_attributes
  end

  def valid_attributes
    {:user_id => @user, :valor => 1356, :valor_currency => "EUR"}
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # SaldosBancarioController. Be sure to keep this updated too.
  def valid_session
    {}
  end



  describe "GET edit" do
    it "assigns the requested saldo_bancario as @saldo_bancario" do
      get :edit, {:id => @saldo_bancario.to_param}, valid_session
      assigns(:saldo_bancario).should eq(@saldo_bancario)
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested saldo_bancario" do
        # Assuming there are no other cotizaciones_peso_dolar in the database, this
        # specifies that the SaldoBancario created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        SaldoBancario.any_instance.should_receive(:update_attributes).with({'these' => 'params', "user_id" => @user.id})
        put :update, {:id => @saldo_bancario.to_param, :saldo_bancario => {'these' => 'params'}}, valid_session
      end

      it "assigns the requested saldo_bancario as @saldo_bancario" do
        put :update, {:id => @saldo_bancario.to_param, :saldo_bancario => valid_attributes}, valid_session
        assigns(:saldo_bancario).should eq(@saldo_bancario)
      end

      it "redirects to the saldo_bancario" do
        put :update, {:id => @saldo_bancario.to_param, :saldo_bancario => valid_attributes}, valid_session
        response.should redirect_to(edit_saldo_bancario_path(@saldo_bancario))
      end
    end

    describe "with invalid params" do
      it "assigns the saldo_bancario as @saldo_bancario" do
        # Trigger the behavior that occurs when invalid params are submitted
        SaldoBancario.any_instance.stub(:save).and_return(false)
        put :update, {:id => @saldo_bancario.to_param, :saldo_bancario => {}}, valid_session
        assigns(:saldo_bancario).should eq(@saldo_bancario)
      end

      it "re-renders the 'edit' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        SaldoBancario.any_instance.stub(:save).and_return(false)
        SaldoBancario.any_instance.stub(:errors).and_return('anything')
        put :update, {:id => @saldo_bancario.to_param, :saldo_bancario => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

end