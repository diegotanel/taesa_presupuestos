require "spec_helper"

describe SolicitantesController do
  describe "routing" do

    it "routes to #index" do
      get("/solicitantes").should route_to("solicitantes#index")
    end

    it "routes to #new" do
      get("/solicitantes/new").should route_to("solicitantes#new")
    end

    it "routes to #show" do
      get("/solicitantes/1").should route_to("solicitantes#show", :id => "1")
    end

    it "routes to #edit" do
      get("/solicitantes/1/edit").should route_to("solicitantes#edit", :id => "1")
    end

    it "routes to #create" do
      post("/solicitantes").should route_to("solicitantes#create")
    end

    it "routes to #update" do
      put("/solicitantes/1").should route_to("solicitantes#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/solicitantes/1").should route_to("solicitantes#destroy", :id => "1")
    end

  end
end
