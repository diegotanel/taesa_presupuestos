require 'spec_helper'

describe "bancos/new" do
  before(:each) do
    assign(:banco, stub_model(Banco,
                              :detalle => "MyString"
                              ).as_new_record)
    assign(:empresas, [])
  end

  it "renders new banco form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => bancos_path, :method => "post" do
      assert_select "input#banco_detalle", :name => "banco[detalle]"
    end
  end
end
