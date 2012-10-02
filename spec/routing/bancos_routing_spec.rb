require "spec_helper"

describe BancosController do
  describe "routing" do

    it "routes to #index" do
      get("/bancos").should route_to("bancos#index")
    end

    it "routes to #new" do
      get("/bancos/new").should route_to("bancos#new")
    end

    it "routes to #show" do
      get("/bancos/1").should route_to("bancos#show", :id => "1")
    end

    it "routes to #edit" do
      get("/bancos/1/edit").should route_to("bancos#edit", :id => "1")
    end

    it "routes to #create" do
      post("/bancos").should route_to("bancos#create")
    end

    it "routes to #update" do
      put("/bancos/1").should route_to("bancos#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/bancos/1").should route_to("bancos#destroy", :id => "1")
    end

  end
end
