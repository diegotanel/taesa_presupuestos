class SaldoBancarioHistorico < ActiveRecord::Base
  belongs_to :user
  belongs_to :saldo_bancario
  attr_accessible :valor, :valor_cents, :valor_currency, :user_id, :saldo_bancario, :fecha_de_alta

  monetize :valor_cents, :with_model_currency => :valor_currency

  validates :user_id, :presence => true
  validates :saldo_bancario, :presence => true
  validates :valor, :presence => true, :numericality => true
  validates :valor_currency, :presence => true
  validates :fecha_de_alta, :presence => true
end
