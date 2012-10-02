require 'spec_helper'

describe "Rubros" do
  before do
    @user = Factory(:user)
    integration_sign_in(@user)
  end

  it "link de acceso" do
    visit home_path
    response.should have_selector("a", :href => rubros_path, :content => "Rubros")
    click_link "Rubros"
    response.should render_template('rubros/index')
  end
end
