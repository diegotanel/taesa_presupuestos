class CreateSolicitantes < ActiveRecord::Migration
  def change
    create_table :solicitantes do |t|
      t.string :detalle, :null => false

      t.timestamps
    end
  end
end
