require 'spec_helper'

describe CotizacionesPesoDolarHistoricoController do

 # This should return the minimal set of attributes required to create a valid
  # SaldoBancarioHistorico. As you add validations to SaldoBancarioHistorico, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    @user = Factory(:user)
    @cotizacion = Factory(:cotizacion_peso_dolar, :user => @user)
    @cpdh = { :user_id => @user.id, :cotizacion_peso_dolar => @cotizacion, :valor => @cotizacion.valor_cents, :valor_currency => @cotizacion.valor_currency }
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # CotizacionesPesoDolarHistoricoController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all cotizacion_peso_dolar_historico as @cotizaciones_peso_dolar_bancario_historico" do
      cotizacion_peso_dolar_historico = CotizacionPesoDolarHistorico.create! valid_attributes
      get :index, {}, valid_session
      assigns(:cotizaciones_peso_dolar_historico).should eq([cotizacion_peso_dolar_historico])
    end
  end

end
