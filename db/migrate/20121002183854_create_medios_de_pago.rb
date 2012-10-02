class CreateMediosDePago < ActiveRecord::Migration
  def change
    create_table :medios_de_pago do |t|
      t.string :detalle, :null => false

      t.timestamps
    end
  end
end
