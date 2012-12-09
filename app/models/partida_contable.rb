class PartidaContable < ActiveRecord::Base
  belongs_to :empresa
  belongs_to :banco
  belongs_to :solicitante
  belongs_to :canal_de_solicitud
  belongs_to :rubro
  belongs_to :cliente_proveedor
  belongs_to :producto_trabajo
  belongs_to :motivo_de_baja_presupuestaria
  has_many :cancelaciones
  attr_accessible :deleted_at, :detalle, :estado, :fecha_de_vencimiento, :importe, :importe_cents, :importe_currency, :tipo_de_movimiento, :valor_dolar_cents, :valor_dolar_currency
  attr_accessible :empresa_id, :banco_id, :solicitante_id, :canal_de_solicitud_id, :rubro_id, :cliente_proveedor_id, :producto_trabajo_id, :motivo_de_baja_presupuestaria_id

  monetize :importe_cents, :with_model_currency => :importe_currency
  monetize :valor_dolar_cents, :with_model_currency => :valor_dolar_currency

  validates :importe, :numericality => { :greater_than => 0.00 }
  validates :importe_currency, :presence => true
  validates :valor_dolar, :numericality => { :greater_than => 0.00 }
  validates :valor_dolar_currency, :presence => true
  validates :fecha_de_vencimiento, :presence => true
  validates :empresa, :presence => true
  validates :solicitante, :presence => true
  validates :canal_de_solicitud, :presence => true
  validates :rubro, :presence => true
  validates :cliente_proveedor, :presence => true
  validates :producto_trabajo, :presence => true
  validates :estado, :presence => true
  validates :tipo_de_movimiento, :presence => true

  TIPODEMONEDA = %w[ARS USD]

  ESTADOS = { :activa => 1, :cumplida => 2, :parcial => 3 }
  TIPODEMOVIMIENTO = {:entrada => 1, :salida => 2}

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
    self.estado = PartidaContable::ESTADOS[:cumplida]
  end

  private

  after_initialize :init

  def init
    self.estado ||= PartidaContable::ESTADOS[:activa]
  end

end
