require 'spec_helper'

describe InformePresupuestario do
  it "debe responder a las propiedades" do
    InformePresupuestario.new.should respond_to(:generar)
  end

  describe "generar informe" do
    it "generar informe con un banco" do
      @empresa = Factory(:empresa, :detalle => "Calmin")
      @banco = Factory(:banco, :detalle => "Banco Provincia Buenos Aires")
      @saldo_bancario = Factory(:saldo_bancario, :valor_cents => "250000", :banco => @banco, :empresa => @empresa)
      fechaDeTransaccion = Time.zone.parse("17/05/2012 23:45")
      Time.stub!(:now).and_return(fechaDeTransaccion)
      @pc1 = Factory(:partida_contable, :importe_cents => 40600000, :importe_currency => "ARS", :tipo_de_movimiento => PartidaContable::TIPODEMOVIMIENTO[:salida], :banco => nil, :empresa => @empresa, :detalle => "Ferrari Venta 1000 Tn Trigo")
      @pc2 = Factory(:partida_contable, :importe_cents => 14000000, :importe_currency => "ARS", :tipo_de_movimiento => PartidaContable::TIPODEMOVIMIENTO[:salida], :banco => @banco, :empresa => @empresa, :detalle => "Siembra soja")

      @hash = {
        :empresa => "Calmin",
        :nombre_bancos => ["Banco Provincia Buenos Aires"],
        :fecha_del_informe => fechaDeTransaccion,
        :asientos => [{
                        :fecha => @saldo_bancario.updated_at,
                        :detalle => @saldo_bancario.detalle,
                        :banco_sin_asignar => [{
                                                 :saldo => Money.new(0, "ARS")
                        }],
                        :bancos => [{
                                      :debe => @saldo_bancario.valor,
                                      :haber => Money.new(0, "ARS"),
                                      :saldo => @saldo_bancario.valor
                        }],
                        :saldo_total => @saldo_bancario.valor
                      },
                      {
                        :fecha => Asiento.new(@pc1).fecha,
                        :detalle => Asiento.new(@pc1).detalle,
                        :banco_sin_asignar => [{
                                                 :saldo => Asiento.new(@pc1).importe
                        }],
                        :bancos => [{
                                      :debe => Money.new(0, "ARS"),
                                      :haber => Money.new(0, "ARS"),
                                      :saldo => Money.new(250000, "ARS")
                        }],
                        :saldo_total => Money.new(40850000, "ARS")
                      },
                      {
                        :fecha => Asiento.new(@pc2).fecha,
                        :detalle => Asiento.new(@pc2).detalle,
                        :banco_sin_asignar => [{
                                                 :saldo => Money.new(0, "ARS")
                        }],
                        :bancos => [{
                                      :debe => Money.new(0, "ARS"),
                                      :haber => Asiento.new(@pc2).importe,
                                      :saldo => Money.new(-13750000, "ARS")
                        }],
                        :saldo_total => Money.new(26850000, "ARS")
                      }
                      ]}
      InformePresupuestario.new.generar(@empresa).to_s.should == @hash.to_s
    end

    it "it generar informe con dos banco" do
      @empresa = Factory(:empresa, :detalle => "Calmin")
      @banco1 = Banco.create!(:detalle => "Banco Provincia Buenos Aires")
      @banco2 = Banco.create!(:detalle => "Citibank")
      @user = Factory(:user)

      @saldo_bancario1 = @empresa.saldos_bancario.create!(:banco_id => @banco1.id, :user_id => @user, :valor => Money.new(250000, "ARS"))
      @saldo_bancario2 = @empresa.saldos_bancario.create!(:banco_id => @banco2.id, :user_id => @user, :valor => Money.new(2189100, "ARS"))

      fechaDeTransaccion = Time.zone.parse("17/05/2012 23:45")
      Time.stub!(:now).and_return(fechaDeTransaccion)
      @pc1 = Factory(:partida_contable, :importe_cents => 40600000, :importe_currency => "ARS", :tipo_de_movimiento => PartidaContable::TIPODEMOVIMIENTO[:salida], :banco => nil, :empresa => @empresa, :detalle => "Ferrari Venta 1000 Tn Trigo")
      @pc2 = Factory(:partida_contable, :importe_cents => 14000000, :importe_currency => "ARS", :tipo_de_movimiento => PartidaContable::TIPODEMOVIMIENTO[:salida], :banco => @banco1, :empresa => @empresa, :detalle => "Siembra soja")

      # @movimientos = [
      #   [40600000, PartidaContable::TIPODEMOVIMIENTO[:salida], nil],
      #   [14000000, PartidaContable::TIPODEMOVIMIENTO[:salida], @banco1],
        # [19200000, PartidaContable::TIPODEMOVIMIENTO[:salida], @banco1],
        # [1691429, PartidaContable::TIPODEMOVIMIENTO[:salida], @banco1],
        # [500000, PartidaContable::TIPODEMOVIMIENTO[:salida], @banco2],
        # [1200000, PartidaContable::TIPODEMOVIMIENTO[:salida], @banco1],
        # [3658200, PartidaContable::TIPODEMOVIMIENTO[:salida], @banco1],
        # [1100000, PartidaContable::TIPODEMOVIMIENTO[:salida], @banco1],
      # ]

      @ultimoSaldoTotalFinanciero = Money.new(0, "ARS")
      @ultimoSaldoBancarioCalculado1 = Money.new(0, "ARS")
      @ultimoSaldoBancarioCalculado2 = Money.new(0, "ARS")

      asiento1 = Asiento.new(@saldo_bancario1)
      @ultimoSaldoBancarioCalculado1 = asiento1.calcular_saldo(@ultimoSaldoBancarioCalculado1)
      @ultimoSaldoTotalFinanciero = asiento1.calcular_saldo_total_financiero(@ultimoSaldoTotalFinanciero)

      asiento2 = Asiento.new(@saldo_bancario2)
      @ultimoSaldoBancarioCalculado2 = asiento2.calcular_saldo(@ultimoSaldoBancarioCalculado2)
      @ultimoSaldoTotalFinanciero = asiento2.calcular_saldo_total_financiero(@ultimoSaldoTotalFinanciero)
      @saldos = { @banco1.id => @ultimoSaldoBancarioCalculado1, @banco2.id => @ultimoSaldoBancarioCalculado2 }

      @hash = {
        :empresa => "Calmin",
        :nombre_bancos => ["Banco Provincia Buenos Aires", "Citibank"],
        :fecha_del_informe => fechaDeTransaccion,
        :asientos => [{
                        :fecha => @saldo_bancario1.updated_at,
                        :detalle => @saldo_bancario1.detalle,
                        :banco_sin_asignar => [{
                                                 :saldo => Money.new(0, "ARS")
                        }],
                        :bancos => [{
                                      :debe => @saldo_bancario1.valor,
                                      :haber => Money.new(0, "ARS"),
                                      :saldo => @saldo_bancario1.valor
                                    },
                                    {
                                      :debe => Money.new(0, "ARS"),
                                      :haber => Money.new(0, "ARS"),
                                      :saldo => Money.new(0, "ARS")
                        }],
                        :saldo_total => @saldo_bancario1.valor
                      },
                      {
                        :fecha => @saldo_bancario2.updated_at,
                        :detalle => @saldo_bancario2.detalle,
                        :banco_sin_asignar => [{
                                                 :saldo => Money.new(0, "ARS")
                        }],
                        :bancos => [{
                                      :debe => Money.new(0, "ARS"),
                                      :haber => Money.new(0, "ARS"),
                                      :saldo => Money.new(250000, "ARS")
                                    },
                                    {
                                      :debe => @saldo_bancario2.valor,
                                      :haber => Money.new(0, "ARS"),
                                      :saldo => @saldo_bancario2.valor
                        }],
                        :saldo_total => Money.new(2439100, "ARS")
                      },
                      {
                        :fecha => Asiento.new(@pc1).fecha,
                        :detalle => Asiento.new(@pc1).detalle,
                        :banco_sin_asignar => [{
                                                 :saldo => Money.new(40600000, "ARS")
                        }],
                        :bancos => [{
                                      :debe => Money.new(0, "ARS"),
                                      :haber => Money.new(0, "ARS"),
                                      :saldo => Money.new(250000, "ARS")
                                    },
                                    {
                                      :debe => Money.new(0, "ARS"),
                                      :haber => Money.new(0, "ARS"),
                                      :saldo => Money.new(2189100, "ARS")
                        }],
                        :saldo_total => Money.new(43039100, "ARS")
                      },
                      {
                        :fecha => Asiento.new(@pc2).fecha,
                        :detalle => Asiento.new(@pc2).detalle,
                        :banco_sin_asignar => [{
                                                 :saldo => Money.new(0, "ARS")
                        }],
                        :bancos => [{
                                      :debe => Money.new(0, "ARS"),
                                      :haber => Money.new(14000000, "ARS"),
                                      :saldo => Money.new(-13750000, "ARS")
                                    },
                                    {
                                      :debe => Money.new(0, "ARS"),
                                      :haber => Money.new(0, "ARS"),
                                      :saldo => Money.new(2189100, "ARS")
                        }],
                        :saldo_total => Money.new(29039100, "ARS")
                      }
                      ]}
      InformePresupuestario.new.generar(@empresa).to_s.should == @hash.to_s
    end

  end
end
