require "spec_helper"

describe PartidasContableController do
  describe "routing" do

    it "routes to #index" do
      get("/partidas_contable").should route_to("partidas_contable#index")
    end

    it "routes to #new" do
      get("/partidas_contable/new").should route_to("partidas_contable#new")
    end

    it "routes to #show" do
      get("/partidas_contable/1").should route_to("partidas_contable#show", :id => "1")
    end

    it "routes to #edit" do
      get("/partidas_contable/1/edit").should route_to("partidas_contable#edit", :id => "1")
    end

    it "routes to #create" do
      post("/partidas_contable").should route_to("partidas_contable#create")
    end

    it "routes to #update" do
      put("/partidas_contable/1").should route_to("partidas_contable#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/partidas_contable/1").should route_to("partidas_contable#destroy", :id => "1")
    end

  end
end
