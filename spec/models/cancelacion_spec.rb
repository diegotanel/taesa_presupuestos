#encoding: utf-8

require 'spec_helper'

describe Cancelacion do
  before do
    @pc = Factory(:partida_contable)
    @medio_de_pago = Factory(:medio_de_pago)
    @attr = { :medio_de_pago => @medio_de_pago, :fecha_de_ingreso => DateTime.now, :importe => 1356 , :importe_currency => "EUR"}
  end

  it "con atributos válidos debe crear una nueva instancia" do
    @pc.cancelaciones.create!(@attr)
  end

  it "la creacion de la cancelacion es por medio de una partida contable" do
    Cancelacion.new(@attr.merge(:partida_contable => @pc)).should_not be_valid
  end

  describe "válido" do
    before do
      @cancelacion = @pc.cancelaciones.create(@attr)
    end

    it "debe responder a partida contable" do
      @cancelacion.should respond_to(:partida_contable)
    end

    it "debe responder a fecha de ingreso" do
      @cancelacion.should respond_to(:fecha_de_ingreso)
    end

    it "debe responder a medio de pago" do
      @cancelacion.should respond_to(:medio_de_pago)
    end

    it "debe responder a importe_cents" do
      @cancelacion.should respond_to(:importe_cents)
    end

    it "debe responder a importe_currency" do
      @cancelacion.should respond_to(:importe_currency)
    end

    it "debe responder a importe" do
      @cancelacion.should respond_to(:importe)
    end

    it "valor es del tipo money" do
      @cancelacion.importe == Money.new(@attr[:importe], @attr[:importe_currency])
    end

    it "debe responder a observaciones" do
      @cancelacion.should respond_to(:observaciones)
    end

    it "debe responder a estado" do
      @cancelacion.should respond_to(:estado)
    end

    it "debe responder a anular" do
      @cancelacion.should respond_to(:anular)
    end

    it "debe tener asociada la partida contable correcta" do
      @cancelacion.partida_contable_id.should == @pc.id
      @cancelacion.partida_contable.should == @pc
    end

    describe "validación estado" do
      it "debe estar como activa" do
        @cancelacion.estado.should == "Activa"
      end

      it "no puede ser nulo" do
        cancelacion = @pc.cancelaciones.build(@attr.merge(:estado => nil))
        cancelacion.estado.should == "Activa"
      end

      it "no debe aceptar valores" do
        cancelacion = @pc.cancelaciones.build(@attr.merge(:estado => "hola"))
        cancelacion.estado.should == "Activa"
      end

      it "debe cambiar el estado a anulada" do
        @cancelacion.anular
        @cancelacion.estado.should == "Anulada"
      end

    end

    describe "validaciones fecha de ingreso" do
      it "no puede ser blanco" do
        @pc.cancelaciones.new(@attr.merge(:fecha_de_ingreso => "")).should_not be_valid
      end

      it "no puede ser nulo" do
        @pc.cancelaciones.new(@attr.merge(:fecha_de_ingreso => nil)).should_not be_valid
      end
    end

    describe "validaciones medio de pago" do
      it "no puede ser nulo" do
        @pc.cancelaciones.new(@attr.merge(:medio_de_pago => nil)).should_not be_valid
      end
    end

    describe "validaciones importe" do
      it "should require nonblank content" do
        @pc.cancelaciones.new(@attr.merge(:importe => "")).should_not be_valid
      end

      it "no puede ser nulo" do
        @pc.cancelaciones.new(@attr.merge(:importe => nil)).should_not be_valid
      end

      it "should require nonblank content" do
        @pc.cancelaciones.new(@attr.merge(:importe => "a")).should_not be_valid
      end

      it "no puede ser cero" do
        @pc.cancelaciones.new(@attr.merge(:importe => 0.00)).should_not be_valid
      end

      it "no puede ser inferior a cero" do
        @pc.cancelaciones.new(@attr.merge(:importe => -0.01)).should_not be_valid
      end

      it "should require nonblank content" do
        @pc.cancelaciones.new(@attr.merge(:importe_currency => "")).should_not be_valid
      end
    end
  end
end
