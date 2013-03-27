#encoding: utf-8

require 'spec_helper'

describe Asiento do
  it "debe inicializarce con una partida contable" do
    lambda do
      @asiento = Asiento.new
    end.should raise_error(ArgumentError)
  end

  describe "validación de propiedades" do
    it "debe responder a las propiedades" do
      @pc = Factory(:partida_contable)
      @asiento = Asiento.new(@pc)
      @asiento.should respond_to(:calcular_saldo)
      @asiento.should respond_to(:importe)
      @asiento.should respond_to(:fecha)
      @asiento.should respond_to(:detalle)
      @asiento.should respond_to(:banco)
      @asiento.should respond_to(:debe)
      @asiento.should respond_to(:haber)
      @asiento.should respond_to(:calcular_saldo_total_financiero)
    end

    it "debe retornar la fecha correcta" do
      fechaDeTransaccion = Time.zone.parse("17/05/2012 23:45")
      Time.stub!(:now).and_return(fechaDeTransaccion)
      @pc = Factory(:partida_contable, :fecha_de_vencimiento => fechaDeTransaccion)
      Asiento.new(@pc).fecha.should == @pc.fecha_de_vencimiento
    end

    it "debe retornar la fecha de actualización del saldo" do
      fechaDeTransaccion = Time.zone.parse("17/05/2012 23:45")
      @saldo_bancario = Factory(:saldo_bancario, :updated_at => fechaDeTransaccion)
      Asiento.new(@saldo_bancario).fecha.should == @saldo_bancario.updated_at
    end

    it "debe retornar el detalle correcto" do
      @pc = Factory(:partida_contable, :detalle => "detalle prueba")
      Asiento.new(@pc).detalle.should == @pc.detalle
    end

    it "debe retornar el banco correcto" do
      @banco = Factory(:banco)
      @pc = Factory(:partida_contable, :banco => @banco)
      Asiento.new(@pc).banco.should == @pc.banco
    end

    it "debe retornar un banco si no hay un banco asignado" do
      @banco = Banco.new(:detalle => "Sin banco asignado")
      @pc = Factory(:partida_contable, :banco => nil)
      Asiento.new(@pc).banco.should.eql? @banco
    end

    describe "cálculo de saldos" do
      it "cálculo de saldo de partida contable de entrada" do
        @pc = Factory(:partida_contable, :importe_cents => 20000, :importe_currency => "ARS", :tipo_de_movimiento => PartidaContable::TIPODEMOVIMIENTO[:entrada])
        @asiento = Asiento.new(@pc)
        @ultimoSaldo = Money.new(16000, "ARS")
        @asiento.calcular_saldo(@ultimoSaldo).should == Money.new(36000, "ARS")
      end

      it "cálculo de saldo de partida contable de salida" do
        @pc = Factory(:partida_contable, :importe_cents => 20000, :importe_currency => "ARS", :tipo_de_movimiento => PartidaContable::TIPODEMOVIMIENTO[:salida])
        @asiento = Asiento.new(@pc)
        @ultimoSaldo = Money.new(16000, "ARS")
        @asiento.calcular_saldo(@ultimoSaldo).should == Money.new(-4000, "ARS")
      end

      it "cálculo de saldo de partida contable de entrada sin banco asignado" do
        @pc = Factory(:partida_contable, :importe_cents => 20000, :importe_currency => "ARS", :tipo_de_movimiento => PartidaContable::TIPODEMOVIMIENTO[:entrada], :banco => nil)
        @asiento = Asiento.new(@pc)
        @ultimoSaldo = Money.new(16000, "ARS")
        @asiento.calcular_saldo(@ultimoSaldo).should == Money.new(16000, "ARS")
      end

      it "cálculo de saldo de partida contable de salida sin banco asignado" do
        @pc = Factory(:partida_contable, :importe_cents => 20000, :importe_currency => "ARS", :tipo_de_movimiento => PartidaContable::TIPODEMOVIMIENTO[:salida], :banco => nil)
        @asiento = Asiento.new(@pc)
        @ultimoSaldo = Money.new(16000, "ARS")
        @asiento.calcular_saldo(@ultimoSaldo).should == Money.new(16000, "ARS")
      end

      it "obtener los saldos bancarios de una empresa" do
        @saldo_bancario = Factory(:saldo_bancario, :valor_cents => "20000")
        @asiento = Asiento.new(@saldo_bancario)
        @ultimoSaldo = Money.new(16000, "ARS")
        @asiento.calcular_saldo(@ultimoSaldo).should == Money.new(36000, "ARS")
      end

      it "el asiento es del debe" do
        @pc = Factory(:partida_contable, :importe_cents => 20000, :importe_currency => "ARS", :tipo_de_movimiento => PartidaContable::TIPODEMOVIMIENTO[:entrada])
        Asiento.new(@pc).debe.should == Money.new(20000, "ARS")
      end

      it "el asiento no es del debe" do
        @pc = Factory(:partida_contable, :importe_cents => 20000, :importe_currency => "ARS", :tipo_de_movimiento => PartidaContable::TIPODEMOVIMIENTO[:salida])
        Asiento.new(@pc).debe.should == Money.new(0, "ARS")
      end

      it "el asiento es del haber" do
        @pc = Factory(:partida_contable, :importe_cents => 20000, :importe_currency => "ARS", :tipo_de_movimiento => PartidaContable::TIPODEMOVIMIENTO[:salida])
        Asiento.new(@pc).haber.should == Money.new(20000, "ARS")
      end

      it "el asiento no es del haber" do
        @pc = Factory(:partida_contable, :importe_cents => 20000, :importe_currency => "ARS", :tipo_de_movimiento => PartidaContable::TIPODEMOVIMIENTO[:entrada])
        Asiento.new(@pc).haber.should == Money.new(0, "ARS")
      end

      it "el asiento no es del debe ni del haber" do
        @pc = Factory(:partida_contable, :importe_cents => 20000, :importe_currency => "ARS", :tipo_de_movimiento => PartidaContable::TIPODEMOVIMIENTO[:entrada], :banco => nil)
        Asiento.new(@pc).debe.should == Money.new(0, "ARS")
        Asiento.new(@pc).haber.should == Money.new(0, "ARS")
      end

      it "el asiento es de un saldo bancario" do
        @saldo_bancario = Factory(:saldo_bancario, :valor_cents => 20000, :valor_currency => "ARS")
        Asiento.new(@saldo_bancario).debe.should == Money.new(20000, "ARS")
        Asiento.new(@saldo_bancario).haber.should == Money.new(0, "ARS")
      end

      it "cálculo del saldo de un banco" do
        @saldo_bancario = Factory(:saldo_bancario, :valor_cents => "250000")
        @movimientos = [
          [14000000, PartidaContable::TIPODEMOVIMIENTO[:entrada]],
          [19200000, PartidaContable::TIPODEMOVIMIENTO[:salida]],
          [1691429, PartidaContable::TIPODEMOVIMIENTO[:salida]],
          [1200000, PartidaContable::TIPODEMOVIMIENTO[:salida]],
          [3658200, PartidaContable::TIPODEMOVIMIENTO[:salida]],
          [1100000, PartidaContable::TIPODEMOVIMIENTO[:salida]],
        ]

        @ultimoSaldo = Money.new(0, "ARS")
        @ultimoSaldo += Asiento.new(@saldo_bancario).calcular_saldo(@ultimoSaldo)
        @movimientos.each { |movimiento|
          pc = Factory(:partida_contable, :importe_cents => movimiento[0], :importe_currency => "ARS", :tipo_de_movimiento => movimiento[1])
          @ultimoSaldo = Asiento.new(pc).calcular_saldo(@ultimoSaldo)
        }
        @ultimoSaldo.should == Money.new(-12599629, "ARS")
      end

      it "calcular saldo de dos bancos" do
        @empresa = Factory(:empresa, :detalle => "Calmin")
        @banco1 = Banco.create!(:detalle => "Banco Provincia Buenos Aires")
        @banco2 = Banco.create!(:detalle => "Citibank")
        @user = Factory(:user)

        @saldo_bancario1 = @empresa.saldos_bancario.create!(:banco_id => @banco1.id, :user_id => @user, :valor => Money.new(250000, "ARS"))
        @saldo_bancario2 =@empresa.saldos_bancario.create!(:banco_id => @banco2.id, :user_id => @user, :valor => Money.new(2189100, "ARS"))

        @movimientosBanco1 = [
          [14000000, PartidaContable::TIPODEMOVIMIENTO[:entrada]],
          [19200000, PartidaContable::TIPODEMOVIMIENTO[:salida]],
          [1691429, PartidaContable::TIPODEMOVIMIENTO[:salida]],
          [1200000, PartidaContable::TIPODEMOVIMIENTO[:salida]],
          [3658200, PartidaContable::TIPODEMOVIMIENTO[:salida]],
          [1100000, PartidaContable::TIPODEMOVIMIENTO[:salida]],
        ]

        @movimientosBanco2 = [
          [500000, PartidaContable::TIPODEMOVIMIENTO[:salida]]
        ]

        @ultimoSaldoBancarioCalculado1 = Money.new(0, "ARS")
        @ultimoSaldoBancarioCalculado1 += Asiento.new(@saldo_bancario1).calcular_saldo(@ultimoSaldoBancarioCalculado1)
        @movimientosBanco1.each { |movimiento|
          pc = Factory(:partida_contable, :importe_cents => movimiento[0], :importe_currency => "ARS", :tipo_de_movimiento => movimiento[1], :banco => @banco1)
          @ultimoSaldoBancarioCalculado1 = Asiento.new(pc).calcular_saldo(@ultimoSaldoBancarioCalculado1)
        }
        @ultimoSaldoBancarioCalculado1.should == Money.new(-12599629, "ARS")

        @ultimoSaldoBancarioCalculado2 = Money.new(0, "ARS")
        @ultimoSaldoBancarioCalculado2 += Asiento.new(@saldo_bancario2).calcular_saldo(@ultimoSaldoBancarioCalculado2)
        @movimientosBanco2.each { |movimiento|
          pc = Factory(:partida_contable, :importe_cents => movimiento[0], :importe_currency => "ARS", :tipo_de_movimiento => movimiento[1], :banco => @banco2)
          @ultimoSaldoBancarioCalculado2 = Asiento.new(pc).calcular_saldo(@ultimoSaldoBancarioCalculado2)
        }
        @ultimoSaldoBancarioCalculado2.should == Money.new(1689100, "ARS")
      end

      it "calcular el saldo total financiero" do
        @empresa = Factory(:empresa, :detalle => "Calmin")
        @banco = Factory(:banco, :detalle => "Banco Provincia Buenos Aires")
        @pcs = []
        @pcs << Factory(:saldo_bancario, :valor_cents => "250000", :banco => @banco, :empresa => @empresa)
        fechaDeTransaccion = Time.zone.parse("17/05/2012 23:45")
        Time.stub!(:now).and_return(fechaDeTransaccion)
        @pcs << Factory(:partida_contable, :importe_cents => 40600000, :importe_currency => "ARS", :tipo_de_movimiento => PartidaContable::TIPODEMOVIMIENTO[:salida], :banco => nil, :empresa => @empresa, :detalle => "Ferrari Venta 1000 Tn Trigo")
        @pcs << Factory(:partida_contable, :importe_cents => 14000000, :importe_currency => "ARS", :tipo_de_movimiento => PartidaContable::TIPODEMOVIMIENTO[:salida], :banco => @banco, :empresa => @empresa, :detalle => "Siembra soja")
        @saldoBancarioCalculado = Money.new(0, "ARS")
        @ultimoSaldoTotalFinanciero = Money.new(0, "ARS")
        @pcs.each { |pc|
          asiento = Asiento.new(pc)
          @saldoBancarioCalculado = asiento.calcular_saldo(@saldoBancarioCalculado)
          @ultimoSaldoTotalFinanciero = asiento.calcular_saldo_total_financiero(@ultimoSaldoTotalFinanciero)
        }
        @ultimoSaldoTotalFinanciero.should == Money.new(26850000, "ARS")
      end

      it "calcular el saldo total financiero con dos bancos" do
        @empresa = Factory(:empresa, :detalle => "Calmin")
        @banco1 = Banco.create!(:detalle => "Banco Provincia Buenos Aires")
        @banco2 = Banco.create!(:detalle => "Citibank")
        @user = Factory(:user)

        @saldo_bancario1 = @empresa.saldos_bancario.create!(:banco_id => @banco1.id, :user_id => @user, :valor => Money.new(250000, "ARS"))
        @saldo_bancario2 = @empresa.saldos_bancario.create!(:banco_id => @banco2.id, :user_id => @user, :valor => Money.new(2189100, "ARS"))

        @movimientos = [
          [40600000, PartidaContable::TIPODEMOVIMIENTO[:salida], nil],
          [14000000, PartidaContable::TIPODEMOVIMIENTO[:salida], @banco1],
          [19200000, PartidaContable::TIPODEMOVIMIENTO[:salida], @banco1],
          [1691429, PartidaContable::TIPODEMOVIMIENTO[:salida], @banco1],
          [500000, PartidaContable::TIPODEMOVIMIENTO[:salida], @banco2],
          [1200000, PartidaContable::TIPODEMOVIMIENTO[:salida], @banco1],
          [3658200, PartidaContable::TIPODEMOVIMIENTO[:salida], @banco1],
          [1100000, PartidaContable::TIPODEMOVIMIENTO[:salida], @banco1],
        ]

        @ultimoSaldoTotalFinanciero = Money.new(0, "ARS")
        @ultimoSaldoTotalFinanciero = Asiento.new(@saldo_bancario1).calcular_saldo_total_financiero(@ultimoSaldoTotalFinanciero)
        @ultimoSaldoTotalFinanciero = Asiento.new(@saldo_bancario2).calcular_saldo_total_financiero(@ultimoSaldoTotalFinanciero)

        @movimientos.each { |movimiento|
          pc = Factory(:partida_contable, :importe_cents => movimiento[0], :importe_currency => "ARS", :tipo_de_movimiento => movimiento[1], :banco => movimiento[2])
          @ultimoSaldoTotalFinanciero = Asiento.new(pc).calcular_saldo_total_financiero(@ultimoSaldoTotalFinanciero)
        }
        @ultimoSaldoTotalFinanciero.should == Money.new(1689471, "ARS")
      end

    end
  end
end
