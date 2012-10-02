class CreateCanalesDeSolicitud < ActiveRecord::Migration
  def change
    create_table :canales_de_solicitud do |t|
      t.string :detalle, :null => false

      t.timestamps
    end
  end
end
