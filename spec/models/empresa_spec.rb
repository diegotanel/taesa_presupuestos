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

  describe "validations" do
    it "should require a detalle" do
      Empresa.new(@attr.merge(:detalle => "")).should_not be_valid
    end
  end

  describe "Asociación" do
    before do
      @empresa = Empresa.create!(@attr)
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
        @banco1 = Banco.create!(:detalle => "Banco Galicia")
        @banco2 = Banco.create!(:detalle => "Banco Frances")
        @bancos = [@banco1, @banco2]
        @user = Factory(:user)
      end

      it "debe tener los bancos asociados" do
        @bancos.each { |banco|
          @empresa.saldos_bancario.create!(:banco_id => banco.id, :user_id => @user, :valor => 4)
        }
        @empresa.bancos.should == @bancos
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
end
