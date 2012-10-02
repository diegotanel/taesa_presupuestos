require 'spec_helper'

describe "Proveedores" do
  before do
    @user = Factory(:user)
    integration_sign_in(@user)
  end

  it "link de acceso" do
    visit home_path
    response.should have_selector("a", :href => proveedores_path, :content => "Proveedores")
    click_link "Proveedores"
    response.should render_template('proveedores/index')
  end
end
