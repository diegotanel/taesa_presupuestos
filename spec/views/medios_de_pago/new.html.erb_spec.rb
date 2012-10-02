require 'spec_helper'

describe "medios_de_pago/new" do
  before(:each) do
    assign(:medio_de_pago, stub_model(MedioDePago,
      :detalle => "MyString"
    ).as_new_record)
  end

  it "renders new medio_de_pago form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => medios_de_pago_path, :method => "post" do
      assert_select "input#medio_de_pago_detalle", :name => "medio_de_pago[detalle]"
    end
  end
end
