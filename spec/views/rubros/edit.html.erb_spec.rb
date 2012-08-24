require 'spec_helper'

describe "rubros/edit.html.erb" do
  before(:each) do
    @rubro = assign(:rubro, stub_model(Rubro,
      :detalle => "MyString"
    ))
  end

  it "renders the edit rubro form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => rubros_path(@rubro), :method => "post" do
      assert_select "input#rubro_detalle", :name => "rubro[detalle]"
    end
  end
end
