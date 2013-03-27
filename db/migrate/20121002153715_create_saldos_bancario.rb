class CreateSaldosBancario < ActiveRecord::Migration
  def change
    create_table :saldos_bancario do |t|
      t.references :user, :null => false
      t.references :banco, :null => false
      t.references :empresa, :null => false
      t.integer :valor_cents, :null => false
      t.string :valor_currency, :null => false
      
      t.timestamps
    end
    add_index :saldos_bancario, :user_id
    add_index :saldos_bancario, [:banco_id, :empresa_id], :unique => true
  end
end
