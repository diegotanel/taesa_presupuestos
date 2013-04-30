class CreateEmpresas < ActiveRecord::Migration
  def change
    create_table :empresas do |t|
      t.string :detalle, :null => false
      t.integer :estado, :null => false

      t.timestamps
    end
  end
end
