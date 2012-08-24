require 'spec_helper'

describe "rubros/new.html.erb" do
  before(:each) do
    assign(:rubro, stub_model(Rubro,
      :detalle => "MyString"
    ).as_new_record)
  end

  it "renders new rubro form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => rubros_path, :method => "post" do
      assert_select "input#rubro_detalle", :name => "rubro[detalle]"
    end
  end
end
