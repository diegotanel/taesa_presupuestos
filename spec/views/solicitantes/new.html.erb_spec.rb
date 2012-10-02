require 'spec_helper'

describe "solicitantes/new" do
  before(:each) do
    assign(:solicitante, stub_model(Solicitante,
      :detalle => "MyString"
    ).as_new_record)
  end

  it "renders new solicitante form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => solicitantes_path, :method => "post" do
      assert_select "input#solicitante_detalle", :name => "solicitante[detalle]"
    end
  end
end
