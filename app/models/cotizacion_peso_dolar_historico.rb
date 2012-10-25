class CotizacionPesoDolarHistorico < ActiveRecord::Base
  belongs_to :user
  belongs_to :cotizacion_peso_dolar
  attr_accessible :valor, :valor_cents, :valor_currency, :user_id, :cotizacion_peso_dolar

  monetize :valor_cents, :with_model_currency => :valor_currency

  validates :user_id, :presence => true
  validates :cotizacion_peso_dolar, :presence => true
  validates :valor, :numericality => { :greater_than => 0.00 }
  validates :valor_currency, :presence => true
end
