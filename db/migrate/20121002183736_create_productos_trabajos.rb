class CreateProductosTrabajos < ActiveRecord::Migration
  def change
    create_table :productos_trabajos do |t|
      t.string :detalle, :null => false

      t.timestamps
    end
  end
end
