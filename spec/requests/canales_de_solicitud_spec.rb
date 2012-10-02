require 'spec_helper'

describe "CanalDeSolicituds" do
   before do
    @user = Factory(:user)
    integration_sign_in(@user)
  end

  it "link de acceso" do
    visit home_path
    response.should have_selector("a", :href => canales_de_solicitud_path, :content => "Canales de solicitud")
    click_link "Canales de solicitud"
    response.should render_template('canales_de_solicitud/index')
  end
end
