require 'spec_helper'

describe "ProductoTrabajos" do
  before do
    @user = Factory(:user)
    integration_sign_in(@user)
  end

  it "link de acceso" do
    visit home_path
    response.should have_selector("a", :href => productos_trabajos_path, :content => "Productos Trabajos")
    click_link "Productos Trabajos"
    response.should render_template('productos_trabajos/index')
  end
end
