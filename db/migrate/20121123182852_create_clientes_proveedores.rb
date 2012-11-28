class CreateClientesProveedores < ActiveRecord::Migration
  def change
    create_table :clientes_proveedores do |t|
      t.string :detalle
      t.boolean :cliente, :null => false, :default => false
      t.boolean :proveedor, :null => false, :default => false

      t.timestamps
    end
  end
end
