class SaldoBancario < ActiveRecord::Base
  belongs_to :user
  belongs_to :banco
  belongs_to :empresa
  attr_accessible :valor, :valor_currency, :user_id, :empresa_id

  ESTADOS = {:activa => 1, :deshabilitada => 2 }

  monetize :valor_cents, :with_model_currency => :valor_currency

  validates :user_id, :presence => true
  validates :banco, :presence => true
  validates :empresa_id, :presence => true
  validates :valor, :presence => true, :numericality => true
  validates :valor_currency, :presence => true
  validates :empresa_id, :uniqueness => {:scope => [:banco_id]}
  validates :estado, :presence => true, :inclusion => { :in => SaldoBancario::ESTADOS.values }

  before_update :copiar_a_historico

  
  def copiar_a_historico
    @attr = {:user_id => self.user_id_was, :saldo_bancario => self, :valor_cents => self.valor_cents_was, :valor_currency => self.valor_currency_was, :fecha_de_alta => self.updated_at}
    historico = SaldoBancarioHistorico.new(@attr)
    raise ActiveRecord::Rollback unless historico.save
  end

  def detalle
    "Saldo Bancario #{self.banco.detalle} Contable"
  end

  def tipo_de_movimiento
    PartidaContable::TIPODEMOVIMIENTO[:entrada]
  end

  private

  after_initialize do
    self.estado ||= SaldoBancario::ESTADOS[:activa]
  end
end
