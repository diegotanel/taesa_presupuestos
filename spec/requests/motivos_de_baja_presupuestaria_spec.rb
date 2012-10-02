require 'spec_helper'

describe "MotivoDeBajaPresupuestaria" do
  before do
    @user = Factory(:user)
    integration_sign_in(@user)
  end

  it "link de acceso" do
    visit home_path
    response.should have_selector("a", :href => motivos_de_baja_presupuestaria_path, :content => "Motivos de baja presupuestaria")
    click_link "Motivos de baja presupuestaria"
    response.should render_template('motivos_de_baja_presupuestaria/index')
  end
end
