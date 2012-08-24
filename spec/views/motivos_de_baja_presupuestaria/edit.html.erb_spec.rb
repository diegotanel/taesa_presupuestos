require 'spec_helper'

describe "motivos_de_baja_presupuestaria/edit.html.erb" do
  before(:each) do
    @motivo_de_baja_presupuestaria = assign(:motivo_de_baja_presupuestaria, stub_model(MotivoDeBajaPresupuestaria,
      :detalle => "MyString"
    ))
  end

  it "renders the edit motivo_de_baja_presupuestaria form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => motivos_de_baja_presupuestaria_path(@motivo_de_baja_presupuestaria), :method => "post" do
      assert_select "input#motivo_de_baja_presupuestaria_detalle", :name => "motivo_de_baja_presupuestaria[detalle]"
    end
  end
end
