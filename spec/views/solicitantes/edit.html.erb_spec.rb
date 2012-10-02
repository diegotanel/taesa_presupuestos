require 'spec_helper'

describe "solicitantes/edit" do
  before(:each) do
    @solicitante = assign(:solicitante, stub_model(Solicitante,
      :detalle => "MyString"
    ))
  end

  it "renders the edit solicitante form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => solicitantes_path(@solicitante), :method => "post" do
      assert_select "input#solicitante_detalle", :name => "solicitante[detalle]"
    end
  end
end
