class Cancelacion < ActiveRecord::Base
  belongs_to :partida_contable
  belongs_to :medio_de_pago
  attr_accessible :fecha_de_ingreso, :observaciones, :importe, :importe_cents, :importe_currency, :medio_de_pago, :medio_de_pago_id

  monetize :importe_cents, :with_model_currency => :importe_currency

  ESTADOS = { :activa => 1, :anulada => 2 }

  validates :importe, :numericality => { :greater_than => 0.00 }
  validates :importe_currency, :presence => true
  validates :partida_contable, :presence => true
  validates :fecha_de_ingreso, :presence => true
  validates :medio_de_pago, :presence => true
  validates :estado, :presence => true, :inclusion => { :in => Cancelacion::ESTADOS.values }

  # scope :activas, where(:estado => "Activa", :partida_contable_id => self.partida_contable)
  # scope :activas, joins(:partida_contable).where(:estado => "Activa")



  def anular
    self.estado = Cancelacion::ESTADOS[:anulada]
  end

  private

  after_initialize do
    self.estado ||= Cancelacion::ESTADOS[:activa]
  end

end
