class CreateClientes < ActiveRecord::Migration
  def change
    create_table :clientes do |t|
      t.string :detalle, :null => false

      t.timestamps
    end
  end
end
