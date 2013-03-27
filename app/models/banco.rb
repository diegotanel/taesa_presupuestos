class Banco < ActiveRecord::Base
  has_many :saldos_bancario, :class_name => 'SaldoBancario'
  has_many :empresas, :through => :saldos_bancario

  attr_accessible :detalle, :empresa_ids

  validates :detalle, :presence => true
end
