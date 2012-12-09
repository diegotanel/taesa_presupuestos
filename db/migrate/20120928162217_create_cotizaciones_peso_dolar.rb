class CreateCotizacionesPesoDolar < ActiveRecord::Migration
  def change
    create_table :cotizaciones_peso_dolar do |t|
      t.references :user
      t.integer :valor_cents, :null => false
      t.string :valor_currency, :null => false
      t.datetime :updated_at, :null => false
    end
    add_index :cotizaciones_peso_dolar, :user_id
  end
end
