require "spec_helper"

describe CotizacionesPesoDolarController do
  describe "routing" do

    it "routes to #edit" do
      get("/cotizaciones_peso_dolar/1/edit").should route_to("cotizaciones_peso_dolar#edit", :id => "1")
    end

    it "routes to #update" do
      put("/cotizaciones_peso_dolar/1").should route_to("cotizaciones_peso_dolar#update", :id => "1")
    end

  end
end
