class Cancelacion < ActiveRecord::Base
  belongs_to :partida_contable
  belongs_to :medio_de_pago
  attr_accessible :fecha_de_ingreso, :observaciones, :importe, :importe_cents, :importe_currency, :medio_de_pago, :medio_de_pago_id

  monetize :importe_cents, :with_model_currency => :importe_currency

  validates :importe, :numericality => { :greater_than => 0.00 }
  validates :importe_currency, :presence => true
  validates :partida_contable, :presence => true
  validates :fecha_de_ingreso, :presence => true
  validates :medio_de_pago, :presence => true

  # scope :activas, where(:estado => "Activa", :partida_contable_id => self.partida_contable)
  # scope :activas, joins(:partida_contable).where(:estado => "Activa")

  after_initialize :init

  def init
    self.estado ||= "Activa"
  end

  def anular
    self.estado = "Anulada"
  end


end
