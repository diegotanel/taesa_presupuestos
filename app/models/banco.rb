class Banco < ActiveRecord::Base
  has_and_belongs_to_many :empresas

  attr_accessible :detalle, :empresa_ids

  validates :detalle, :presence => true
end
