class CreatePartidasContable < ActiveRecord::Migration
  def change
    create_table :partidas_contable do |t|
      t.datetime :fecha_actual, :null => false
      t.datetime :fecha_de_vencimiento, :null => false
      t.references :empresa, :null => false
      t.references :banco, :null => false
      t.references :solicitante, :null => false
      t.references :canal_de_solicitud, :null => false
      t.references :rubro, :null => false
      t.integer :importe_cents, :null => false, :default => 0
      t.string :importe_currency, :null => false
      t.string :tipo_de_movimiento, :null => false
      t.belongs_to :referente, :polymorphic => true, :null => false
      t.string :detalle
      t.references :producto_trabajo, :null => false
      t.references :medio_de_pago, :null => false
      t.string :estado, :null => false
      t.references :motivo_de_baja_presupuestaria

      t.timestamps
    end
    add_index :partidas_contable, :empresa_id
    add_index :partidas_contable, :banco_id
    add_index :partidas_contable, :solicitante_id
    add_index :partidas_contable, :canal_de_solicitud_id
    add_index :partidas_contable, :rubro_id
    add_index :partidas_contable, :producto_trabajo_id
    add_index :partidas_contable, :medio_de_pago_id
    add_index :partidas_contable, :motivo_de_baja_presupuestaria_id
    add_index :partidas_contable, :referente_id
    add_index :partidas_contable, :referente_type
  end
end
