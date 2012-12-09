class CreateSaldosBancario < ActiveRecord::Migration
  def change
    create_table :saldos_bancario do |t|
      t.references :user
      t.integer :valor_cents, :null => false
      t.string :valor_currency, :null => false
      t.datetime :updated_at, :null => false
    end
    add_index :saldos_bancario, :user_id
  end
end
