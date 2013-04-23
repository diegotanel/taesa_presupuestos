class PartidaContable < ActiveRecord::Base
  belongs_to :empresa
  belongs_to :banco
  belongs_to :solicitante
  belongs_to :canal_de_solicitud
  belongs_to :rubro
  belongs_to :cliente_proveedor
  belongs_to :producto_trabajo
  belongs_to :motivo_de_baja_presupuestaria
  has_many :cancelaciones, :after_add => :cambiar_a_parcial
  attr_accessible :deleted_at, :detalle, :empresa_id, :fecha_de_vencimiento, :importe, :importe_cents, :importe_currency, :tipo_de_movimiento, :valor_dolar, :valor_dolar_cents, :valor_dolar_currency
  attr_accessible :banco_id, :solicitante_id, :canal_de_solicitud_id, :rubro_id, :cliente_proveedor_id, :producto_trabajo_id, :motivo_de_baja_presupuestaria_id

  monetize :importe_cents, :with_model_currency => :importe_currency
  monetize :valor_dolar_cents, :with_model_currency => :valor_dolar_currency

  ESTADOS = { :activa => 1, :cumplida => 2, :parcial => 3 }

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
  validates :estado, :presence => true, :inclusion => { :in => PartidaContable::ESTADOS.values }
  validates :tipo_de_movimiento, :presence => true
  validates :detalle, :presence => true

  TIPODEMONEDA = %w[ARS USD]


  TIPODEMOVIMIENTO = {:entrada => 1, :salida => 2}

  def cancelaciones_activas
    return self.cancelaciones.where(:estado => Cancelacion::ESTADOS[:activa])
  end

  def importe_total_cancelado
    # self.cancelaciones.where(:estado => Cancelacion::ESTADOS[:activa])
    # .map(&:importe)
    # .inject(Money.new(0, self.importe_currency), :+)
    @resultado = Money.new(0, self.importe_currency)
    self.cancelaciones.where(:estado => Cancelacion::ESTADOS[:activa])
    .each { |c|
      if c.importe_currency == self.importe_currency
        @resultado += c.importe
      else
        if self.importe_currency == "ARS"
          Money.add_rate("USD", "ARS", c.valor_dolar.amount)
          @resultado += c.importe
        else
          Money.add_rate("ARS", "USD", 1/c.valor_dolar.amount)
          @resultado += c.importe
        end
      end
    }
    @resultado
  end

  def resta_cancelar
    self.importe - importe_total_cancelado
  end

  def dar_por_cumplida
    self.estado = PartidaContable::ESTADOS[:cumplida]
  end

  private

  after_initialize do
    self.estado ||= PartidaContable::ESTADOS[:activa]
  end

  def cambiar_a_parcial(cancelacion)
    self.estado = PartidaContable::ESTADOS[:parcial] if self.cancelaciones.count == 0
  end

end
