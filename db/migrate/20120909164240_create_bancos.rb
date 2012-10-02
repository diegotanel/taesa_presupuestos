class CreateBancos < ActiveRecord::Migration
  def change
    create_table :bancos do |t|
      t.string :detalle, :null => false

      t.timestamps
    end
  end
end
