require 'spec_helper'

describe "canales_de_solicitud/edit" do
  before(:each) do
    @canal_de_solicitud = assign(:canal_de_solicitud, stub_model(CanalDeSolicitud,
      :detalle => "MyString"
    ))
  end

  it "renders the edit canal_de_solicitud form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => canales_de_solicitud_path(@canal_de_solicitud), :method => "post" do
      assert_select "input#canal_de_solicitud_detalle", :name => "canal_de_solicitud[detalle]"
    end
  end
end
