class Empresa < ActiveRecord::Base
  has_many :saldos_bancario, :class_name => 'SaldoBancario'
  has_many :bancos, :through => :saldos_bancario
  has_many :partidas_contable, :class_name => 'PartidaContable'
  attr_accessible :detalle

  validates :detalle, :presence => true

  def partidas_contables_pendientes
    return self.partidas_contable.where(
      :estado => [PartidaContable::ESTADOS[:activa],
                  PartidaContable::ESTADOS[:parcial]]
    ).order('fecha_de_vencimiento ASC')
  end
end
