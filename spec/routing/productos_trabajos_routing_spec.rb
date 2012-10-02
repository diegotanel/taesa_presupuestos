require "spec_helper"

describe ProductosTrabajosController do
  describe "routing" do

    it "routes to #index" do
      get("/productos_trabajos").should route_to("productos_trabajos#index")
    end

    it "routes to #new" do
      get("/productos_trabajos/new").should route_to("productos_trabajos#new")
    end

    it "routes to #show" do
      get("/productos_trabajos/1").should route_to("productos_trabajos#show", :id => "1")
    end

    it "routes to #edit" do
      get("/productos_trabajos/1/edit").should route_to("productos_trabajos#edit", :id => "1")
    end

    it "routes to #create" do
      post("/productos_trabajos").should route_to("productos_trabajos#create")
    end

    it "routes to #update" do
      put("/productos_trabajos/1").should route_to("productos_trabajos#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/productos_trabajos/1").should route_to("productos_trabajos#destroy", :id => "1")
    end

  end
end
