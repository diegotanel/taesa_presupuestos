#encoding: utf-8

require 'spec_helper'

describe Empresa do
  before(:each) do
    @attr = {:detalle => "detalle1"}
  end

  it "con atributos válidos debe crear una nueva instancia" do
    Empresa.create!(@attr)
  end

  it "debe tener el atributo detalle" do
    Empresa.new(@attr).should respond_to(:detalle)
  end

  it "debe responder a saldos bancario" do
    Empresa.new(@attr).should respond_to(:saldos_bancario)
  end

  it "debe responder a saldos bancario" do
    Empresa.new(@attr).should respond_to(:estado)
  end

  it "debe responder a anular" do
    Empresa.new(@attr).should respond_to(:anular)
  end

  it "debe responder a activar" do
    Empresa.new(@attr).should respond_to(:activar)
  end

  it "debe responder a activas" do
    Empresa.should respond_to(:activas)
  end

  it "debe responder a deshabilitadas" do
    Empresa.should respond_to(:deshabilitadas)
  end

  describe "validations" do
    describe "detalle" do
      it "should require a detalle" do
        Empresa.new(@attr.merge(:detalle => "")).should_not be_valid
      end
    end

    describe "estado" do
      before do
        @empresa = Empresa.new(@attr)
      end

      it "debe inicializarse con estado activa" do
        @empresa.estado.should_not be_nil
      end

      it "debe ser requerido" do
        @empresa.estado = nil
        @empresa.should_not be_valid
      end

      it "debe estar como activa" do
        @empresa.estado.should == Empresa::ESTADOS[:activa]
      end

      it "no puede ser nulo" do
        lambda {
          @empresa.estado = nil
          @empresa.save!
        }.should raise_error(ActiveRecord::RecordInvalid)
      end

      it "no debe aceptar valores" do
        @empresa.estado = 23
        @empresa.should_not be_valid
      end

      it "debe cambiar el estado a activa" do
        @empresa.anular
        @empresa.estado.should == Empresa::ESTADOS[:deshabilitada]
        @empresa.activar
        @empresa.estado.should == Empresa::ESTADOS[:activa]
      end

      it "debe cambiar el estado a deshabilitada" do
        @empresa.anular
        @empresa.estado.should == Empresa::ESTADOS[:deshabilitada]
      end
    end

  end

  describe "Asociación" do
    before do
      @empresa = Empresa.new(@attr)
    end

    it "debe responder a bancos" do
      @empresa.should respond_to(:bancos)
    end

    it "debe responder a partidas contables" do
      @empresa.should respond_to(:partidas_contable)
    end

    it "debe responder a las partidas_contables_pendientes" do
      @empresa.should respond_to(:partidas_contables_pendientes)
    end

    describe "verificación de asociación con banco" do
      before do
        @empresa1 = Empresa.create!(:detalle => "TAESA")
        @empresa2 = Empresa.create!(:detalle => "Chantaco")
        @empresa3 = Empresa.create!(:detalle => "SuperFito")
        @empresas = [@empresa1, @empresa2, @empresa3]

        @banco = Banco.create!(:detalle => "Banco Galicia")
        @user = Factory(:user)
      end

      it "debe tener los banco asociados" do
        @empresas.each { |empresa|
          @banco.saldos_bancario.create!(:empresa_id => empresa.id, :user_id => @user, :valor => 4)
        }
        @banco.empresas.should == @empresas
      end
    end

    describe "verificación de asociación con partidas_contable" do
      before do
        @fechaDeTransaccion = Time.zone.parse("17/05/2012 23:45")
        Time.stub!(:now).and_return(@fechaDeTransaccion)
        @pc1 = Factory(:partida_contable, :empresa => @empresa, :fecha_de_vencimiento => @fechaDeTransaccion)
        @pc2 = Factory(:partida_contable, :empresa => @empresa, :importe_cents => 100000, :fecha_de_vencimiento => @fechaDeTransaccion)
      end

      it "debe tener las partidas contable asociadas" do
        @empresa.partidas_contable.should == [@pc1, @pc2]
      end

      it "debe retornar las pcs pendientes (activas, parciales y vencidas)" do
        pc3parcial = Factory(:partida_contable, :empresa => @empresa)
        attrCancelacion = { :medio_de_pago => Factory(:medio_de_pago), :fecha_de_ingreso => DateTime.now, :importe => 1356 , :importe_currency => "EUR", :valor_dolar => Money.new(4, "ARS")}
        pc3parcial.cancelaciones.create!(attrCancelacion)
        pc3parcial.save
        pc3parcial.reload

        pc4vencida = Factory(:partida_contable, :empresa => @empresa, :fecha_de_vencimiento => 1.day.ago)
        pc5cumplida = Factory(:partida_contable, :empresa => @empresa, :estado => PartidaContable::ESTADOS[:cumplida])
        @empresa.partidas_contables_pendientes.should =~ [@pc1, @pc2, pc3parcial, pc4vencida]
      end

      it "debe retornar las pcs pendientes ordenadas por fecha de vencimiento" do
        @pc1.fecha_de_vencimiento = @fechaDeTransaccion + 5.days
        @pc2.fecha_de_vencimiento = @fechaDeTransaccion + 3.days
        @pc3 = Factory(:partida_contable, :empresa => @empresa, :fecha_de_vencimiento => @fechaDeTransaccion + 10.days)
        @pc4 = Factory(:partida_contable, :empresa => @empresa, :fecha_de_vencimiento => @fechaDeTransaccion + 4.days)
        @pc1.save
        @pc2.save
        @pc1.reload
        @pc2.reload
        @empresa.partidas_contables_pendientes.should == [@pc2, @pc4, @pc1, @pc3]
      end
    end
  end

  describe "búsqueda por activas y deshabilitadas" do
    before do
      @empresa1 = Factory(:empresa, :detalle => "TAESA", :estado => Empresa::ESTADOS[:activa])
      @empresa2 = Factory(:empresa, :detalle => "Chantaco", :estado => Empresa::ESTADOS[:deshabilitada])
      @empresa3 = Factory(:empresa, :detalle => "SuperFito", :estado => Empresa::ESTADOS[:activa])
    end

    it "debe obtener las empresas activas" do
      @resultado = Empresa.activas
      @resultado.should =~ [@empresa1, @empresa3]
    end

    it "debe obtener las empresas deshabilitadas" do
      @resultado = Empresa.deshabilitadas
      @resultado.should =~ [@empresa2]
    end
  end
end
