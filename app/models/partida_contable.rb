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
  attr_accessible :detalle, :estado, :fecha_actual, :fecha_de_vencimiento, :importe, :importe_currency, 
  				        :tipo_de_movimiento, :empresa_id, :banco_id, :solicitante_id, :canal_de_solicitud_id,
                  :rubro_id, :producto_trabajo_id, :medio_de_pago_id, :motivo_de_baja_presupuestaria_id,
                  :referente_id, :referente_type

  TIPODEMOVIMIENTO = %w[entrada salida]

  monetize :importe_cents, :with_model_currency => :importe_currency, :with_currency => :usd

  validates :importe, :numericality => { :greater_than => 0.00 }
  validates :importe_currency, :presence => true

end
