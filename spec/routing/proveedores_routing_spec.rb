require "spec_helper"

describe ProveedoresController do
  describe "routing" do

    it "routes to #index" do
      get("/proveedores").should route_to("proveedores#index")
    end

    it "routes to #new" do
      get("/proveedores/new").should route_to("proveedores#new")
    end

    it "routes to #show" do
      get("/proveedores/1").should route_to("proveedores#show", :id => "1")
    end

    it "routes to #edit" do
      get("/proveedores/1/edit").should route_to("proveedores#edit", :id => "1")
    end

    it "routes to #create" do
      post("/proveedores").should route_to("proveedores#create")
    end

    it "routes to #update" do
      put("/proveedores/1").should route_to("proveedores#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/proveedores/1").should route_to("proveedores#destroy", :id => "1")
    end

  end
end
