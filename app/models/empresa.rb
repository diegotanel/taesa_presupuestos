class Empresa < ActiveRecord::Base
  has_and_belongs_to_many :bancos
  attr_accessible :detalle

  validates :detalle, :presence => true
end
