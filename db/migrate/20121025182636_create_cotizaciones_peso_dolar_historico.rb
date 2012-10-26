class CreateCotizacionesPesoDolarHistorico < ActiveRecord::Migration
  def change
    create_table :cotizaciones_peso_dolar_historico do |t|
      t.references :user, :null => false
      t.references :cotizacion_peso_dolar, :null => false
      t.integer :valor_cents, :null => false, :default => 0
      t.string :valor_currency, :null => false
      t.datetime :fecha_de_alta, :null => false
      t.datetime :created_at, :null => false
    end
    add_index :cotizaciones_peso_dolar_historico, :user_id
    add_index :cotizaciones_peso_dolar_historico, :cotizacion_peso_dolar_id, :name => 'index_cpdh_on_cotizacion_peso_dolar_id'
  end
end
