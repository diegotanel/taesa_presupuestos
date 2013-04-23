class CreatePartidasContable < ActiveRecord::Migration
  def change
    create_table :partidas_contable do |t|
      t.datetime :fecha_de_vencimiento, :null => false
      t.references :empresa, :null => false
      t.references :banco
      t.references :solicitante, :null => false
      t.references :canal_de_solicitud, :null => false
      t.references :rubro, :null => false
      t.integer :importe_cents, :null => false
      t.string :importe_currency, :null => false
      t.integer :valor_dolar_cents, :null => false
      t.string :valor_dolar_currency, :null => false
      t.integer :tipo_de_movimiento, :null => false
      t.references :cliente_proveedor, :null => false
      t.string :detalle, :null => false
      t.references :producto_trabajo, :null => false
      t.integer :estado, :null => false
      t.references :motivo_de_baja_presupuestaria
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :partidas_contable, :empresa_id
    add_index :partidas_contable, :banco_id
    add_index :partidas_contable, :solicitante_id
    add_index :partidas_contable, :canal_de_solicitud_id
    add_index :partidas_contable, :rubro_id
    add_index :partidas_contable, :cliente_proveedor_id
    add_index :partidas_contable, :producto_trabajo_id
    add_index :partidas_contable, :motivo_de_baja_presupuestaria_id
    add_index :partidas_contable, :deleted_at
  end
end
