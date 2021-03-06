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

describe PartidasContableController do
  before do
    Factory(:cotizacion_peso_dolar)
    @empresa = Factory(:empresa)
    @banco = Factory(:banco)
    @solicitante = Factory(:solicitante)
    @canal_de_solicitud = Factory(:canal_de_solicitud)
    @rubro = Factory(:rubro)
    @cliente_proveedor = Factory(:cliente_proveedor)
    @producto_trabajo = Factory(:producto_trabajo)
    @motivo_de_baja_presupuestaria = Factory(:motivo_de_baja_presupuestaria)
  end

  # This should return the minimal set of attributes required to create a valid
  # PartidaContable. As you add validations to PartidaContable, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {
      :fecha_de_vencimiento => DateTime.now,
      :empresa_id => @empresa,
      :banco_id => @banco,
      :solicitante_id => @solicitante,
      :canal_de_solicitud_id => @canal_de_solicitud,
      :rubro_id => @rubro,
      :importe_cents => "1356",
      :importe_currency => "ARS",
      :valor_dolar_cents => "500",
      :valor_dolar_currency => "USD",
      :tipo_de_movimiento => "1",
      :cliente_proveedor_id => @cliente_proveedor,
      :producto_trabajo_id => @producto_trabajo,
      :estado => "1",
      :motivo_de_baja_presupuestaria_id => @motivo_de_baja_presupuestaria,
      :detalle => "texto para detalle"
    }
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # PartidasContableController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all partidas_contable as @partidas_contable" do
      partida_contable = PartidaContable.create! valid_attributes
      get :index, {}, valid_session
      assigns(:partidas_contable).should eq([partida_contable])
    end
  end

  describe "GET show" do
    it "assigns the requested partida_contable as @partida_contable" do
      partida_contable = PartidaContable.create! valid_attributes
      get :show, {:id => partida_contable.to_param}, valid_session
      assigns(:partida_contable).should eq(partida_contable)
    end
  end

  describe "GET new" do
    it "assigns a new partida_contable as @partida_contable" do
      get :new, {}, valid_session
      assigns(:partida_contable).should be_a_new(PartidaContable)
    end
  end

  describe "GET edit" do
    it "assigns the requested partida_contable as @partida_contable" do
      partida_contable = PartidaContable.create! valid_attributes
      get :edit, {:id => partida_contable.to_param}, valid_session
      assigns(:partida_contable).should eq(partida_contable)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new PartidaContable" do
        expect {
          post :create, {:partida_contable => valid_attributes}, valid_session
        }.to change(PartidaContable, :count).by(1)
      end

      it "assigns a newly created partida_contable as @partida_contable" do
        post :create, {:partida_contable => valid_attributes}, valid_session
        assigns(:partida_contable).should be_a(PartidaContable)
        assigns(:partida_contable).should be_persisted
      end

      it "redirects to the created partida_contable" do
        post :create, {:partida_contable => valid_attributes}, valid_session
        response.should redirect_to(PartidaContable.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved partida_contable as @partida_contable" do
        # Trigger the behavior that occurs when invalid params are submitted
        PartidaContable.any_instance.stub(:save).and_return(false)
        post :create, {:partida_contable => {}}, valid_session
        assigns(:partida_contable).should be_a_new(PartidaContable)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        PartidaContable.any_instance.stub(:save).and_return(false)
        PartidaContable.any_instance.stub(:errors).and_return('anything')
        post :create, {:partida_contable => {}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested partida_contable" do
        partida_contable = PartidaContable.create! valid_attributes
        # Assuming there are no other partidas_contable in the database, this
        # specifies that the PartidaContable created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        PartidaContable.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => partida_contable.to_param, :partida_contable => {'these' => 'params'}}, valid_session
      end

      it "assigns the requested partida_contable as @partida_contable" do
        partida_contable = PartidaContable.create! valid_attributes
        put :update, {:id => partida_contable.to_param, :partida_contable => valid_attributes}, valid_session
        assigns(:partida_contable).should eq(partida_contable)
      end

      it "redirects to the partida_contable" do
        partida_contable = PartidaContable.create! valid_attributes
        put :update, {:id => partida_contable.to_param, :partida_contable => valid_attributes}, valid_session
        response.should redirect_to(partida_contable)
      end
    end

    describe "with invalid params" do
      it "assigns the partida_contable as @partida_contable" do
        partida_contable = PartidaContable.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        PartidaContable.any_instance.stub(:save).and_return(false)
        put :update, {:id => partida_contable.to_param, :partida_contable => {}}, valid_session
        assigns(:partida_contable).should eq(partida_contable)
      end

      it "re-renders the 'edit' template" do
        partida_contable = PartidaContable.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        PartidaContable.any_instance.stub(:save).and_return(false)
        PartidaContable.any_instance.stub(:errors).and_return('anything')
        put :update, {:id => partida_contable.to_param, :partida_contable => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested partida_contable" do
      partida_contable = PartidaContable.create! valid_attributes
      expect {
        delete :destroy, {:id => partida_contable.to_param}, valid_session
      }.to change(PartidaContable, :count).by(-1)
    end

    it "redirects to the partidas_contable list" do
      partida_contable = PartidaContable.create! valid_attributes
      delete :destroy, {:id => partida_contable.to_param}, valid_session
      response.should redirect_to(partidas_contable_url)
    end
  end

end
