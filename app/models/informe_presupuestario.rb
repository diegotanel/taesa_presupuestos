class InformePresupuestario
  include ActiveModel::Validations

  def generar(empresa)
    @ultimoSaldoTotalFinanciero = Money.new(0, "ARS")
    @hash = {}
    @hash[:empresa] = empresa.detalle
    @hash[:nombre_bancos] = empresa.saldos_bancario.map { |sb| sb.banco.detalle }
    @hash[:fecha_del_informe] = Time.zone.now
    @asientos = empresa.saldos_bancario.map { |sb| Asiento.new(sb)  }
    empresa.partidas_contables_pendientes.each { |pc| @asientos << Asiento.new(pc)  }
    
    @saldosBancariosCalculados = {}
    empresa.saldos_bancario.each { |sb| @saldosBancariosCalculados[sb.banco.id] = Money.new(0, "ARS") }

    @hash[:asientos] = @asientos.map { |asiento|
      if asiento.banco.id
        @saldosBancariosCalculados[asiento.banco.id] = asiento.calcular_saldo(@saldosBancariosCalculados[asiento.banco.id])
      end
      @ultimoSaldoTotalFinanciero = asiento.calcular_saldo_total_financiero(@ultimoSaldoTotalFinanciero)
      { :fecha => asiento.fecha,
        :detalle => asiento.detalle,
        :banco_sin_asignar => [banco_sin_asignar(asiento)],
        :bancos => columnas_bancos(asiento, @saldosBancariosCalculados),
        :saldo_total => @ultimoSaldoTotalFinanciero }
    }

    return @hash
  end

  private

  def columnas_bancos(asiento, saldosBancariosCalculados)
    columnas = []
    saldosBancariosCalculados.each { |k,v|
      if asiento.banco.id == k
        columnas << { :debe => asiento.debe, :haber => asiento.haber, :saldo => v }
      else
        columnas << { :debe => Money.new(0, "ARS"), :haber => Money.new(0, "ARS"), :saldo => v }
      end
    }
    return columnas
  end

  def banco_sin_asignar(asiento)
    { :saldo => asiento.banco.id ? Money.new(0, "ARS") : asiento.importe }
  end
end
