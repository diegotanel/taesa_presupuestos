require "spec_helper"

describe CanalesDeSolicitudController do
  describe "routing" do

    it "routes to #index" do
      get("/canales_de_solicitud").should route_to("canales_de_solicitud#index")
    end

    it "routes to #new" do
      get("/canales_de_solicitud/new").should route_to("canales_de_solicitud#new")
    end

    it "routes to #show" do
      get("/canales_de_solicitud/1").should route_to("canales_de_solicitud#show", :id => "1")
    end

    it "routes to #edit" do
      get("/canales_de_solicitud/1/edit").should route_to("canales_de_solicitud#edit", :id => "1")
    end

    it "routes to #create" do
      post("/canales_de_solicitud").should route_to("canales_de_solicitud#create")
    end

    it "routes to #update" do
      put("/canales_de_solicitud/1").should route_to("canales_de_solicitud#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/canales_de_solicitud/1").should route_to("canales_de_solicitud#destroy", :id => "1")
    end

  end
end
