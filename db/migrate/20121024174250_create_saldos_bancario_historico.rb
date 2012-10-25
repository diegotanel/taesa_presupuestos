class CreateSaldosBancarioHistorico < ActiveRecord::Migration
  def change
    create_table :saldos_bancario_historico do |t|
      t.references :user, :null => false
      t.references :saldo_bancario, :null => false
      t.integer :valor_cents, :null => false, :default => 0
      t.string :valor_currency, :null => false
      t.datetime :created_at, :null => false
    end
    add_index :saldos_bancario_historico, :user_id
    add_index :saldos_bancario_historico, :saldo_bancario_id
  end
end
