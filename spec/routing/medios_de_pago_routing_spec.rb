require "spec_helper"

describe MediosDePagoController do
  describe "routing" do

    it "routes to #index" do
      get("/medios_de_pago").should route_to("medios_de_pago#index")
    end

    it "routes to #new" do
      get("/medios_de_pago/new").should route_to("medios_de_pago#new")
    end

    it "routes to #show" do
      get("/medios_de_pago/1").should route_to("medios_de_pago#show", :id => "1")
    end

    it "routes to #edit" do
      get("/medios_de_pago/1/edit").should route_to("medios_de_pago#edit", :id => "1")
    end

    it "routes to #create" do
      post("/medios_de_pago").should route_to("medios_de_pago#create")
    end

    it "routes to #update" do
      put("/medios_de_pago/1").should route_to("medios_de_pago#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/medios_de_pago/1").should route_to("medios_de_pago#destroy", :id => "1")
    end

  end
end
