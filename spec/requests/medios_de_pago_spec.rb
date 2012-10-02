require 'spec_helper'

describe "MedioDePagos" do
  before do
    @user = Factory(:user)
    integration_sign_in(@user)
  end

  it "link de acceso" do
    visit home_path
    response.should have_selector("a", :href => medios_de_pago_path, :content => "Medios de pago")
    click_link "Medios de pago"
    response.should render_template('medios_de_pago/index')
  end
end
