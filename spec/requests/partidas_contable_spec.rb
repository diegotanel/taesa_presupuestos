require 'spec_helper'

describe "PartidaContables" do
  describe "GET /partidas_contable" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get partidas_contable_path
      response.status.should be(200)
    end
  end
end
