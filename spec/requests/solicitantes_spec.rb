require 'spec_helper'

describe "Solicitantes" do
  before do
    @user = Factory(:user)
    integration_sign_in(@user)
  end

  it "link de acceso" do
    visit home_path
    response.should have_selector("a", :href => solicitantes_path, :content => "Solicitantes")
    click_link "Solicitantes"
    response.should render_template('solicitantes/index')
  end
end
