class Empresa < ActiveRecord::Base
  has_many :saldos_bancario, :class_name => 'SaldoBancario'
  has_many :bancos, :through => :saldos_bancario
  has_many :partidas_contable, :class_name => 'PartidaContable'
  attr_accessible :detalle

  ESTADOS = {:activa => 1, :deshabilitada => 2 }

  scope :activas, where(:estado => Empresa::ESTADOS[:activa])
  scope :deshabilitadas, where(:estado => Empresa::ESTADOS[:deshabilitada])

  validates :detalle, :presence => true
  validates :estado, :presence => true, :inclusion => { :in => Empresa::ESTADOS.values }

  def partidas_contables_pendientes
    return self.partidas_contable.where(
      :estado => [PartidaContable::ESTADOS[:activa],
                  PartidaContable::ESTADOS[:parcial]]
    ).order('fecha_de_vencimiento ASC')
  end

  def activar
    self.estado = Empresa::ESTADOS[:activa]
  end

  def anular
    self.estado = Empresa::ESTADOS[:deshabilitada]
  end

  private

  after_initialize do
    self.estado ||= Empresa::ESTADOS[:activa]
  end
end
