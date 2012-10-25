class CreateBancosEmpresas < ActiveRecord::Migration
  def up
    create_table :bancos_empresas, :id => false do |t|
      t.integer :banco_id, :null => false
      t.integer :empresa_id, :null => false
    end
    add_index :bancos_empresas, [:banco_id, :empresa_id]
  end
  def down
    drop_table :bancos_empresas
  end
end
