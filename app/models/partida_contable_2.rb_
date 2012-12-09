class PartidaContable < ActiveRecord::Base
  belongs_to :empresa
  belongs_to :banco
  belongs_to :solicitante
  belongs_to :canal_de_solicitud
  belongs_to :rubro
  belongs_to :producto_trabajo
  belongs_to :medio_de_pago
  belongs_to :motivo_de_baja_presupuestaria
  belongs_to :referente, :polymorphic => true
  has_many :cancelaciones
  attr_accessible :detalle, :estado, :fecha_actual, :fecha_de_vencimiento, :importe, :importe_currency,
    :tipo_de_movimiento, :empresa_id, :banco_id, :solicitante_id, :canal_de_solicitud_id,
    :rubro_id, :producto_trabajo_id, :medio_de_pago_id, :motivo_de_baja_presupuestaria_id,
    :referente_id, :referente_type

  TIPODEMOVIMIENTO = %w[entrada salida]
  TIPODEMONEDA = %w[ARS USD]

  monetize :importe_cents, :with_model_currency => :importe_currency

  validates :importe, :numericality => { :greater_than => 0.00 }
  validates :importe_currency, :presence => true

  def cancelaciones_activas
    return self.cancelaciones.where(:estado => "Activa")
  end

  def importe_total_cancelado
    self.cancelaciones.where(:estado => "Activa")
    .map(&:importe)
    .inject(Money.new(0, self.importe_currency), :+)
  end

  def resta_cancelar
    self.importe - importe_total_cancelado
  end

  def dar_por_cumplida
  	self.estado = "Cumplida"
  end

end
