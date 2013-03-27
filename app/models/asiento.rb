class Asiento
  include ActiveModel::Validations

  def initialize(concepto)
    @concepto = concepto
  end

  def importe
    return @concepto.valor if @concepto.respond_to?(:valor)
    return @concepto.importe if @concepto.respond_to?(:importe)
  end

  def fecha
    @concepto.respond_to?(:fecha_de_vencimiento) ? @concepto.fecha_de_vencimiento : @concepto.updated_at
  end

  def detalle
    @concepto.detalle
  end

  def banco
    if @concepto.banco.nil?
      Banco.new(:detalle => "Sin banco asignado")
    else
      @concepto.banco
    end
  end

  def debe
    obtener_columna(:entrada)
  end

  def haber
    obtener_columna(:salida)
  end

  def calcular_saldo(ultimoSaldo)
    return ultimoSaldo unless @concepto.banco
    if @concepto.tipo_de_movimiento == PartidaContable::TIPODEMOVIMIENTO[:entrada]
      ultimoSaldo + self.importe
    else
      ultimoSaldo - self.importe
    end
  end

  def calcular_saldo_total_financiero(ultimoSaldoTotalFinanciero)
    if @concepto.banco.nil? || @concepto.tipo_de_movimiento == PartidaContable::TIPODEMOVIMIENTO[:entrada]
      ultimoSaldoTotalFinanciero + self.importe
    else
      ultimoSaldoTotalFinanciero - self.importe
    end
  end

  private

  def obtener_columna(movimiento)
    if @concepto.banco && @concepto.tipo_de_movimiento == PartidaContable::TIPODEMOVIMIENTO[movimiento]
      self.importe
    else
      Money.new(0, "ARS")
    end
  end

end
