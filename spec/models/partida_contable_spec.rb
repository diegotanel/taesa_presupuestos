#encoding: utf-8

require 'spec_helper'

describe PartidaContable do
  before do
    @attr = {:importe => 1000, :importe_currency => "USD"}
  end

  describe "validación de propiedades" do
    before do
      @pc = Factory(:partida_contable)
    end

    it "debe responder a las propiedades" do
      @pc.should respond_to(:fecha_de_vencimiento)
      @pc.should respond_to(:empresa)
      @pc.should respond_to(:banco)
      @pc.should respond_to(:solicitante)
      @pc.should respond_to(:canal_de_solicitud)
      @pc.should respond_to(:rubro)
      @pc.should respond_to(:importe)
      @pc.should respond_to(:importe_cents)
      @pc.should respond_to(:importe_currency)
      @pc.should respond_to(:valor_dolar)
      @pc.should respond_to(:valor_dolar_cents)
      @pc.should respond_to(:valor_dolar_currency)
      @pc.should respond_to(:tipo_de_movimiento)
      @pc.should respond_to(:cliente_proveedor)
      @pc.should respond_to(:detalle)
      @pc.should respond_to(:producto_trabajo)
      @pc.should respond_to(:estado)
      @pc.should respond_to(:motivo_de_baja_presupuestaria)
      @pc.should respond_to(:deleted_at)
    end

    it "importe es del tipo money" do
      # @pc = Factory(:partida_contable, :importe_cents => 100000)
      @pc.importe == Money.new(@attr[:importe], @attr[:importe_currency])
    end

    it "valor_dolar es del tipo money" do
      # @pc = Factory(:partida_contable, :importe_cents => 100000)
      @pc.valor_dolar == Money.new(@attr[:importe], @attr[:importe_currency])
    end

    describe "fecha_de_vencimiento" do
      it "debe ser requerido" do
        @pc.fecha_de_vencimiento = nil
        @pc.should_not be_valid
      end
    end

    describe "empresa" do
      it "debe ser requerido" do
        @pc.empresa = nil
        @pc.should_not be_valid
      end
    end

    describe "solicitante" do
      it "debe ser requerido" do
        @pc.solicitante = nil
        @pc.should_not be_valid
      end
    end

    describe "canal_de_solicitud" do
      it "debe ser requerido" do
        @pc.canal_de_solicitud = nil
        @pc.should_not be_valid
      end
    end

    describe "rubro" do
      it "debe ser requerido" do
        @pc.rubro = nil
        @pc.should_not be_valid
      end
    end

    describe "tipo_de_movimiento" do
      it "debe ser requerido" do
        @pc.tipo_de_movimiento = nil
        @pc.should_not be_valid
      end
    end

    describe "cliente_proveedor" do
      it "debe ser requerido" do
        @pc.cliente_proveedor = nil
        @pc.should_not be_valid
      end
    end

    describe "producto_trabajo" do
      it "debe ser requerido" do
        @pc.producto_trabajo = nil
        @pc.should_not be_valid
      end
    end

    describe "estado" do
      it "debe ser requerido" do
        @pc.estado = nil
        @pc.should_not be_valid
      end

      it "debe estar como activa" do
        @pc.estado.should == PartidaContable::ESTADOS[:activa]
      end

      it "no puede ser nulo" do
        @pc.estado = nil
        @pc.save
        @pc.reload
        @pc.estado.should == PartidaContable::ESTADOS[:activa]
      end

      it "no debe aceptar valores" do
        @pc.estado = 23
        @pc.should_not be_valid
      end

      # it "debe cambiar el estado a anulada" do
      #   @cancelacion.anular
      #   @cancelacion.estado.should == PartidaContable::ESTADOS[:anulada]
      # end
    end

    describe "importe" do
      it "importe es del tipo money" do
        @pc.importe = nil
        @pc.should_not be_changed
      end

      it "should require nonblank content" do
        @pc.importe = Money.new("", @attr[:importe_currency])
        @pc.should_not be_valid
      end

      it "no puede ser nulo" do
        @pc.importe = Money.new(nil, @attr[:importe_currency])
        @pc.should_not be_valid
      end

      it "should require nonblank content" do
        @pc.importe = Money.new("a", @attr[:importe_currency])
        @pc.should_not be_valid
      end
      it "no puede ser cero" do
        @pc.importe = Money.new(0.00, @attr[:importe_currency])
        @pc.should_not be_valid
      end

      it "no puede ser inferior a cero" do
        @pc.importe = Money.new(-0.01, @attr[:importe_currency])
        @pc.should_not be_valid
      end

      it "should require nonblank content" do
        lambda do
          @pc.importe = Money.new(@attr[:importe_cents], "")
        end.should raise_error(Money::Currency::UnknownCurrency)
      end
    end

    describe "valor_dolar" do
      it "valor_dolar es del tipo money" do
        @pc.valor_dolar = nil
        @pc.should_not be_changed
      end

      it "should require nonblank content" do
        @pc.valor_dolar = Money.new("", @attr[:valor_dolar_currency])
        @pc.should_not be_valid
      end

      it "no puede ser nulo" do
        @pc.valor_dolar = Money.new(nil, @attr[:valor_dolar_currency])
        @pc.should_not be_valid
      end

      it "should require nonblank content" do
        @pc.valor_dolar = Money.new("a", @attr[:valor_dolar_currency])
        @pc.should_not be_valid
      end
      it "no puede ser cero" do
        @pc.valor_dolar = Money.new(0.00, @attr[:valor_dolar_currency])
        @pc.should_not be_valid
      end

      it "no puede ser inferior a cero" do
        @pc.valor_dolar = Money.new(-0.01, @attr[:valor_dolar_currency])
        @pc.should_not be_valid
      end

      it "should require nonblank content" do
        lambda do
          @pc.valor_dolar = Money.new(@attr[:valor_dolar_cents], "")
        end.should raise_error(Money::Currency::UnknownCurrency)
      end
    end

    describe "Detalle" do
      it "debe ser requerido" do
        @pc.detalle = nil
        @pc.should_not be_valid
      end

      it "debe contener algún dato" do
        @pc.detalle = ""
        @pc.should_not be_valid
      end
    end
  end

  describe "asociación con cancelación" do
    before do
      @pc = Factory(:partida_contable, :importe_cents => 100000)
    end

    it "debe responder a las cancelaciones" do
      @pc.should respond_to(:cancelaciones)
    end

    it "debe responder a resta cancelar" do
      @pc.should respond_to(:resta_cancelar)
    end

    it "debe responder a importe total cancelado" do
      @pc.should respond_to(:importe_total_cancelado)
    end

    it "debe responder a dar por cumplida" do
      @pc.should respond_to(:dar_por_cumplida)
    end

    it "debe cambiar el estado de la partida contable a parcial" do
      # @medio_de_pago = Factory(:medio_de_pago)
      @pc.cancelaciones.build(:medio_de_pago => Factory(:medio_de_pago), :fecha_de_ingreso => DateTime.now, :importe => Money.new(1356, "USD"), :valor_dolar => Money.new(607, "ARS"))
      @pc.save
      @pc.reload
      @pc.estado.should == PartidaContable::ESTADOS[:parcial]
    end

    it "no debe cambiar el estado de la partida contable a parcial" do
      @medio_de_pago = Factory(:medio_de_pago)
      PartidaContable.any_instance.stub(:save).and_return(false)
      @pc.cancelaciones.build(:medio_de_pago => @medio_de_pago, :fecha_de_ingreso => DateTime.now, :importe => Money.new(1356, "USD"), :valor_dolar => Money.new(607, "ARS"))
      @pc.save
      @pc.reload
      @pc.estado.should == PartidaContable::ESTADOS[:activa]
    end

    describe "cancelaciones activas" do
      before do
        @attr = { :medio_de_pago => Factory(:medio_de_pago), :fecha_de_ingreso => DateTime.now, :importe => Money.new(91050, "ARS"), :valor_dolar => Money.new(607, "ARS")}
        @cancelacion1 = @pc.cancelaciones.create!(@attr)
        @cancelacion2 = @pc.cancelaciones.create!(@attr.merge(:importe => Money.new(121400, "ARS")))
        @cancelacion3 = @pc.cancelaciones.create!(@attr.merge(:importe => Money.new(242800, "ARS")))
        @cancelacion2.anular
        @cancelacion2.save
      end

      it "debe mostrar la suma de las cancelaciones activas" do
        @pc.importe_total_cancelado.should == Money.new(333850,"ARS")
      end

      it "obtener las cancelaciones activas de la partida contable correspondiente" do
        @pc2 = Factory(:partida_contable)
        @medio_de_pago = Factory(:medio_de_pago)
        @attr2 = { :medio_de_pago => @medio_de_pago, :fecha_de_ingreso => DateTime.now, :importe => Money.new(8231, "ARS"), :valor_dolar => Money.new(607, "ARS")}
        @cancelacion4pc2 = @pc2.cancelaciones.create!(@attr2)
        @pc.cancelaciones_activas.should == [@cancelacion1, @cancelacion3]
        @pc2.cancelaciones_activas.should == [@cancelacion4pc2]
      end
    end

    # it "debe responder a adicionar_cancelacion" do
    #   @pc.should respond_to(:adicionar_cancelacion)
    # end

    # it "debe responder a eliminar_cancelacion" do
    #   @pc.should respond_to(:eliminar_cancelacion)
    # end

    # it "debe adicionar una cancelacion a la partida contable" do
    #   @medio_de_pago = Factory(:medio_de_pago)
    #   @cancelacion = Cancelacion.build(:medio_de_pago => @medio_de_pago, :fecha_de_ingreso => DateTime.now, :importe => Money.new(150, "USD")})
    #   @pc.adicionar_cancelacion
    #   @pc.cancelaciones.first
    # end
  end

  describe "importe total cancelado" do
    before do
      # @attr = { :medio_de_pago => Factory(:medio_de_pago), :fecha_de_ingreso => DateTime.now, :importe => Money.new(150, "USD"), :valor_dolar => Money.new(607, "ARS")}
      # Money.add_rate("USD", "ARS", "6.07")
    end

    it "si no tiene ninguna cancelación el resultado debe ser cero" do
      @pc = Factory(:partida_contable)
      @pc.cancelaciones.count.should == 0
      @pc.importe_total_cancelado.should == Money.new(0, "ARS")
    end

    it "debe sumar las cancelaciones de la misma moneda" do
      @pc = Factory(:partida_contable)
      @attr = { :medio_de_pago => Factory(:medio_de_pago), :fecha_de_ingreso => DateTime.now, :importe => Money.new(31254, "ARS"), :valor_dolar => Money.new(607, "ARS")}
      @pc.cancelaciones.create!(@attr)
      @pc.cancelaciones.create!(@attr.merge(:importe => Money.new(2398, "ARS")))
      @pc.importe_total_cancelado.should == Money.new(33652, "ARS")
    end

    describe "suma de cancelaciones de distintas monedas" do
      it "partida contable en pesos con una cancelación en dólares" do
        # Money.add_rate("USD", "ARS", "6.07")
        @pc = Factory(:partida_contable)
        @attr = { :medio_de_pago => Factory(:medio_de_pago), :fecha_de_ingreso => DateTime.now, :importe => Money.new(91050, "ARS"), :valor_dolar => Money.new(607, "ARS")}
        @pc.cancelaciones.create!(@attr)
        @pc.cancelaciones.create!(@attr.merge(:importe => Money.new(20000, "USD")))
        @pc.importe_total_cancelado.should == Money.new(212450, "ARS")
      end

      it "partida contable en dólares con una cancelación en pesos" do
        # Money.add_rate("ARS", "USD", "0.164744646")
        @pc = Factory(:partida_contable, :importe_cents => 10000, :importe_currency => "USD")
        @attr = { :medio_de_pago => Factory(:medio_de_pago), :fecha_de_ingreso => DateTime.now, :importe => Money.new(23000, "ARS"), :valor_dolar => Money.new(607, "ARS")}
        @pc.cancelaciones.create!(@attr)
        @pc.cancelaciones.create!(@attr.merge(:importe => Money.new(2396, "USD")))
        @pc.importe_total_cancelado.should == Money.new(6185, "USD")
      end
    end
  end

  describe "resta cancelar" do
    it "si no tiene ninguna cancelación debe mostrar el monto de la partida contable" do
      @pc = Factory(:partida_contable)
      @pc.resta_cancelar.should == @pc.importe
    end

    it "con una cancelación en la misma" do
      @pc = Factory(:partida_contable, :importe_cents => 100000)
      @attr = { :medio_de_pago => Factory(:medio_de_pago), :fecha_de_ingreso => DateTime.now, :importe => Money.new(23415, "ARS"), :valor_dolar => Money.new(607, "ARS")}
      @pc.cancelaciones.create!(@attr)
      @pc.resta_cancelar.should == Money.new(76585,"ARS")
    end

    describe "suma de cancelaciones de distintas monedas" do
      it "partida contable en pesos con una cancelación en dólares" do
        @pc = Factory(:partida_contable, :importe_cents => 100000)
        @attr = { :medio_de_pago => Factory(:medio_de_pago), :fecha_de_ingreso => DateTime.now, :importe => Money.new(150, "USD"), :valor_dolar => Money.new(607, "ARS")}
        @pc.cancelaciones.create!(@attr)
        @pc.cancelaciones.create!(@attr.merge(:importe => Money.new(23116, "ARS")))
        @pc.resta_cancelar.should == Money.new(75974, "ARS")
      end

      it "partida contable en pesos con una cancelación en dólares con distintas cotizaciones" do
        @pc = Factory(:partida_contable, :importe_cents => 100000)
        @attr = { :medio_de_pago => Factory(:medio_de_pago), :fecha_de_ingreso => DateTime.now, :importe => Money.new(150, "USD"), :valor_dolar => Money.new(631, "ARS")}
        @pc.cancelaciones.create!(@attr)
        @pc.cancelaciones.create!(@attr.merge(:importe => Money.new(23116, "ARS")))
        @pc.resta_cancelar.should == Money.new(75938, "ARS")
      end

      it "partida contable en dólares con una cancelación en pesos" do
        @pc = Factory(:partida_contable, :importe_cents => 10000, :importe_currency => "USD")
        @attr = { :medio_de_pago => Factory(:medio_de_pago), :fecha_de_ingreso => DateTime.now, :importe => Money.new(23000, "ARS"), :valor_dolar => Money.new(607, "ARS")}
        @pc.cancelaciones.create!(@attr)
        @pc.cancelaciones.create!(@attr.merge(:importe => Money.new(2396, "USD")))
        @pc.resta_cancelar.should == Money.new(3815, "USD")
      end

      it "partida contable en dólares con una cancelación en pesos con distintas cotizaciones" do
        @pc = Factory(:partida_contable, :importe_cents => 10000, :importe_currency => "USD")
        @attr = { :medio_de_pago => Factory(:medio_de_pago), :fecha_de_ingreso => DateTime.now, :importe => Money.new(23000, "ARS"), :valor_dolar => Money.new(631, "ARS")}
        @pc.cancelaciones.create!(@attr)
        @pc.cancelaciones.create!(@attr.merge(:importe => Money.new(2396, "USD")))
        @pc.resta_cancelar.should == Money.new(3959, "USD")
      end

    end
  end

  describe "dar por cumplida" do
    it "debe cambiar el estado a cumplida" do
      @pc = Factory(:partida_contable, :importe_cents => 100000)
      @pc.dar_por_cumplida
      @pc.estado.should == PartidaContable::ESTADOS[:cumplida]
    end
  end

  describe "verificación de asociación con partidas_contable" do
    before do
      @empresa = Factory(:empresa)
      @banco = Factory(:banco)
      @solicitante = Factory(:solicitante)
      @canal_de_solicitud = Factory(:canal_de_solicitud)
      @rubro = Factory(:rubro)
      @medio_de_pago = Factory(:medio_de_pago)
      @cliente_proveedor = Factory(:cliente_proveedor)
      @producto_trabajo = Factory(:producto_trabajo)
      @attr2 = { :fecha_de_vencimiento => DateTime.now, :importe => 1356 , :importe_currency => "EUR", :valor_dolar => Money.new(4, "ARS"),
                 :solicitante_id => @solicitante, :canal_de_solicitud_id => @canal_de_solicitud, :rubro_id => @rubro, :cliente_proveedor_id => @cliente_proveedor,
                 :producto_trabajo_id => @producto_trabajo, :tipo_de_movimiento => 1, :detalle => "texto" }
      @pc = @empresa.partidas_contable.create!(@attr2)
    end

    it "debe tener los pcs asociados" do
      @pc.empresa_id.should == @empresa.id
      @pc.empresa.should == @empresa
    end

    it "obtener las pcs pendientes de una empresa" do

    end
  end
end
