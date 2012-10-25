require "spec_helper"

describe SaldosBancarioHistoricoController do
  describe "routing" do
    it "routes to #index" do
      get("/saldos_bancario_historico").should route_to("saldos_bancario_historico#index")
    end
  end
end
