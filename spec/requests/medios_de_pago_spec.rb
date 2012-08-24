require 'spec_helper'

describe "MedioDePagos" do
  describe "GET /medios_de_pago" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get medios_de_pago_path
      response.status.should be(200)
    end
  end
end
