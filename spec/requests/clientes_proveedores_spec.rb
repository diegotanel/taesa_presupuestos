require 'spec_helper'

describe "ClienteProveedores" do
  before do
    @user = Factory(:user)
    integration_sign_in(@user)
  end

  it "link de acceso" do
    visit home_path
    response.should have_selector("a", :href => clientes_proveedores_path, :content => "Clientes Proveedores")
    click_link "Clientes Proveedores"
    response.should render_template('clientes_proveedores/index')
  end
end
