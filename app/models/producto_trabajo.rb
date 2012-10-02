class ProductoTrabajo < ActiveRecord::Base
  attr_accessible :detalle

  validates :detalle, :presence => true
end
