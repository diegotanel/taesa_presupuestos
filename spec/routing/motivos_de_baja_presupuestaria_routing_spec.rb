require "spec_helper"

describe MotivosDeBajaPresupuestariaController do
  describe "routing" do

    it "routes to #index" do
      get("/motivos_de_baja_presupuestaria").should route_to("motivos_de_baja_presupuestaria#index")
    end

    it "routes to #new" do
      get("/motivos_de_baja_presupuestaria/new").should route_to("motivos_de_baja_presupuestaria#new")
    end

    it "routes to #show" do
      get("/motivos_de_baja_presupuestaria/1").should route_to("motivos_de_baja_presupuestaria#show", :id => "1")
    end

    it "routes to #edit" do
      get("/motivos_de_baja_presupuestaria/1/edit").should route_to("motivos_de_baja_presupuestaria#edit", :id => "1")
    end

    it "routes to #create" do
      post("/motivos_de_baja_presupuestaria").should route_to("motivos_de_baja_presupuestaria#create")
    end

    it "routes to #update" do
      put("/motivos_de_baja_presupuestaria/1").should route_to("motivos_de_baja_presupuestaria#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/motivos_de_baja_presupuestaria/1").should route_to("motivos_de_baja_presupuestaria#destroy", :id => "1")
    end

  end
end
