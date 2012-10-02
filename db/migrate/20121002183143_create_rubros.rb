class CreateRubros < ActiveRecord::Migration
  def change
    create_table :rubros do |t|
      t.string :detalle, :null => false

      t.timestamps
    end
  end
end
