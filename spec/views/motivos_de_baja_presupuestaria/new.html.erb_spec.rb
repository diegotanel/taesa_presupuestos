require 'spec_helper'

describe "motivos_de_baja_presupuestaria/new" do
  before(:each) do
    assign(:motivo_de_baja_presupuestaria, stub_model(MotivoDeBajaPresupuestaria,
      :detalle => "MyString"
    ).as_new_record)
  end

  it "renders new motivo_de_baja_presupuestaria form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => motivos_de_baja_presupuestaria_path, :method => "post" do
      assert_select "input#motivo_de_baja_presupuestaria_detalle", :name => "motivo_de_baja_presupuestaria[detalle]"
    end
  end
end
