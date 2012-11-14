#encoding: utf-8

require 'spec_helper'

describe PartidaContable do
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

    describe "importe total cancelado" do
      before do
        @medio_de_pago = Factory(:medio_de_pago)
        @attr = { :medio_de_pago => @medio_de_pago, :fecha_de_ingreso => DateTime.now, :importe => Money.new(150, "EUR")}
        Money.add_rate("EUR", "ARS", 6.07)
      end

      it "si no tiene ninguna cancelación el resultado debe ser cero" do
        @pc.cancelaciones.count.should == 0
        @pc.importe_total_cancelado.should == Money.new(0, "ARS")
      end

      it "debe mostrar la suma de las cancelaciones" do
        @pc.cancelaciones.create!(@attr)
        @attr[:importe] = Money.new(200, "EUR")
        @pc.cancelaciones.create!(@attr)
        @pc.importe_total_cancelado.should == Money.new(2124,"ARS")
      end

      describe "activas" do
        before do
          @cancelacion1 = @pc.cancelaciones.create!(@attr)
          @attr[:importe] = Money.new(200, "EUR")
          @cancelacion2 = @pc.cancelaciones.create!(@attr)
          @attr[:importe] = Money.new(400, "EUR")
          @cancelacion3 = @pc.cancelaciones.create!(@attr)
          @cancelacion2.anular
          @cancelacion2.save
        end

        it "debe mostrar la suma de las cancelaciones activas" do
          @pc.importe_total_cancelado.should == Money.new(3338,"ARS")
        end

        # it "obtener las cancelaciones activas de la partida contable correspondiente" do
        #   @pc2 = Factory(:partida_contable)
        #   @medio_de_pago = Factory(:medio_de_pago)
        #   @attr2 = { :medio_de_pago => @medio_de_pago, :fecha_de_ingreso => DateTime.now, :importe => 1356 , :importe_currency => "EUR"}
        #   @cancelacion4pc2 = @pc2.cancelaciones.create!(@attr2)

        #   @pc.activas.should == [@cancelacion1, @cancelacion3]
        # end
      end
    end

    describe "resta cancelar" do
      it "si no tiene ninguna cancelación debe mostrar el monto de la partida contable" do
        @pc.resta_cancelar.should == @pc.importe
      end

      it "con una cancelación" do
        @medio_de_pago = Factory(:medio_de_pago)
        @attr = { :medio_de_pago => @medio_de_pago, :fecha_de_ingreso => DateTime.now, :importe => 150, :importe_currency => "ARS", :estado => "Activo"}
        @pc.cancelaciones.create!(@attr)
        @pc.resta_cancelar.should == Money.new(85000,"ARS")
      end
    end

    describe "dar por cumplida" do
      it "debe cambiar el estado a cumplida" do
        @pc = Factory(:partida_contable, :importe_cents => 100000)
        @pc.dar_por_cumplida
        @pc.estado.should == "Cumplida"
      end
    end
  end
end
