class CreateMediosDePago < ActiveRecord::Migration
  def change
    create_table :medios_de_pago do |t|
      t.string :detalle

      t.timestamps
    end
  end
end
