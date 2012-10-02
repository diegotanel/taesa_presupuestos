class CreateProveedores < ActiveRecord::Migration
  def change
    create_table :proveedores do |t|
      t.string :detalle, :null => false

      t.timestamps
    end
  end
end
