require 'spec_helper'

describe "Clientes" do
  before do
    @user = Factory(:user)
    integration_sign_in(@user)
  end

  it "link de acceso" do
    visit home_path
    response.should have_selector("a", :href => clientes_path, :content => "Clientes")
    click_link "Clientes"
    response.should render_template('clientes/index')
  end
end
