class Banco < ActiveRecord::Base
  has_many :saldos_bancario, :class_name => 'SaldoBancario', :inverse_of => :banco
  has_many :empresas, :through => :saldos_bancario
  before_save :crear_saldos_bancario

  attr_accessible :detalle, :empresa_ids, :empresa_attrib, :user_id

  validates :detalle, :presence => true

  def empresa_attrib=(empresa_attrib)
    @empresa_attrib = empresa_attrib.delete_if(&:empty?)
  end

  def user_id=(id)
    @current_user_id = id
  end

  def empresas_activas_asociadas
    self.empresas.select { |empresa| empresa.estado == Empresa::ESTADOS[:activa]  }
  end

  def empresas_activas_no_asociadas
    Empresa.activas.where("id NOT IN (?)", self.empresa_ids.empty? ? 'nil' : self.empresa_ids)
  end

  private

  def crear_saldos_bancario
    if @empresa_attrib
      @empresa_attrib.map { |e|
        self.saldos_bancario.build(:user_id => @current_user_id, :valor => Money.new(0, "ARS"), :empresa_id => e)
      }
    end
  end

end
