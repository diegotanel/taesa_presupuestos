#encoding: utf-8

require 'spec_helper'

describe "PartidaContables" do
  describe "GET /partidas_contable" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get partidas_contable_path
      response.status.should be(200)
    end

    it "link de acceso a la lista de cancelaciones" do
      @pc = Factory(:partida_contable)
      visit partidas_contable_path
      response.should have_selector("a", :href => partida_contable_cancelaciones_path(@pc), :content => "Cancelación")
      click_link "Cancelación"
      response.should render_template('cancelaciones/index')
    end
  end
end
