require 'spec_helper'

describe "Bancos" do
  before do
    @user = Factory(:user)
    integration_sign_in(@user)
  end

  it "link de acceso" do
    visit home_path
    response.should have_selector("a", :href => bancos_path, :content => "Bancos")
    click_link "Bancos"
    response.should render_template('bancos/index')
  end
end
