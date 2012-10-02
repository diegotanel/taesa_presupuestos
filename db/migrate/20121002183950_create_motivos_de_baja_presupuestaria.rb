class CreateMotivosDeBajaPresupuestaria < ActiveRecord::Migration
  def change
    create_table :motivos_de_baja_presupuestaria do |t|
      t.string :detalle, :null => false

      t.timestamps
    end
  end
end
