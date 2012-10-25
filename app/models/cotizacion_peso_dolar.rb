class CotizacionPesoDolar < ActiveRecord::Base
  belongs_to :user
  attr_accessible :valor, :valor_currency, :user_id

  monetize :valor_cents, :with_model_currency => :valor_currency

  validates :user_id, :presence => true
  validates :valor, :numericality => { :greater_than => 0.00 }
  validates :valor_currency, :presence => true

  before_update :copiar_a_historico

  def copiar_a_historico
    @attr = {:user_id => self.user_id_was, :cotizacion_peso_dolar => self, :valor_cents => self.valor_cents_was, :valor_currency => self.valor_currency_was}
    historico = CotizacionPesoDolarHistorico.new(@attr)
    raise ActiveRecord::Rollback unless historico.save
  end
  
end
