class CreateBancos < ActiveRecord::Migration
  def change
    create_table :bancos do |t|
      t.string :detalle

      t.timestamps
    end
  end
end
