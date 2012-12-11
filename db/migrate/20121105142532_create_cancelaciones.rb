class CreateCancelaciones < ActiveRecord::Migration
  def change
    create_table :cancelaciones do |t|
      t.references :partida_contable, :null => false
      t.datetime :fecha_de_ingreso, :null => false
      t.references :medio_de_pago, :null => false
      t.integer :importe_cents, :null => false
      t.string :importe_currency, :null => false
      t.string :observaciones
      t.integer :estado, :null => false

      t.timestamps
    end
    add_index :cancelaciones, :partida_contable_id
    add_index :cancelaciones, :medio_de_pago_id
  end
end
