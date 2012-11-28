class ClienteProveedor < ActiveRecord::Base
  attr_accessible :cliente, :detalle, :proveedor

  validates :detalle, :presence => true
end
