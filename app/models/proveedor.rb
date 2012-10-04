class Proveedor < ActiveRecord::Base
  attr_accessible :detalle

  # has_many :partidas_contable, :as => :referente, :class_name => "PartidaContable"
  validates :detalle, :presence => true
end
