class CotizacionPesoDolar < ActiveRecord::Base
  belongs_to :user
  attr_accessible :valor, :valor_currency, :user_id

  monetize :valor_cents, :with_model_currency => :valor_currency

  validates :user_id, :presence => true
  validates :valor, :numericality => { :greater_than => 0.00 }
  validates :valor_currency, :presence => true
end
