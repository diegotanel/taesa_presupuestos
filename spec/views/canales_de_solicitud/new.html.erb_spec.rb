require 'spec_helper'

describe "canales_de_solicitud/new" do
  before(:each) do
    assign(:canal_de_solicitud, stub_model(CanalDeSolicitud,
      :detalle => "MyString"
    ).as_new_record)
  end

  it "renders new canal_de_solicitud form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => canales_de_solicitud_path, :method => "post" do
      assert_select "input#canal_de_solicitud_detalle", :name => "canal_de_solicitud[detalle]"
    end
  end
end
