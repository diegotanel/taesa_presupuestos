require 'spec_helper'

describe "Empresas" do
  before do
    @user = Factory(:user)
    integration_sign_in(@user)
  end

  it "link de acceso" do
    visit home_path
    response.should have_selector("a", :href => empresas_path, :content => "Empresas")
    click_link "Empresas"
    response.should render_template('empresas/index')
  end
end
