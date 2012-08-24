require 'spec_helper'

describe "MotivoDeBajaPresupuestaria" do
  describe "GET /motivos_de_baja_presupuestaria" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get motivos_de_baja_presupuestaria_path
      response.status.should be(200)
    end
  end
end
