require "spec_helper"

describe ClientesProveedoresController do
  describe "routing" do

    it "routes to #index" do
      get("/clientes_proveedores").should route_to("clientes_proveedores#index")
    end

    it "routes to #new" do
      get("/clientes_proveedores/new").should route_to("clientes_proveedores#new")
    end

    it "routes to #show" do
      get("/clientes_proveedores/1").should route_to("clientes_proveedores#show", :id => "1")
    end

    it "routes to #edit" do
      get("/clientes_proveedores/1/edit").should route_to("clientes_proveedores#edit", :id => "1")
    end

    it "routes to #create" do
      post("/clientes_proveedores").should route_to("clientes_proveedores#create")
    end

    it "routes to #update" do
      put("/clientes_proveedores/1").should route_to("clientes_proveedores#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/clientes_proveedores/1").should route_to("clientes_proveedores#destroy", :id => "1")
    end

  end
end
