require 'spec_helper'

describe "bancos/edit" do
  before(:each) do
    @banco = assign(:banco, stub_model(Banco,
      :detalle => "MyString"
    ))
  end

  it "renders the edit banco form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => bancos_path(@banco), :method => "post" do
      assert_select "input#banco_detalle", :name => "banco[detalle]"
    end
  end
end
