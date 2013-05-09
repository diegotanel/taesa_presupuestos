#encoding: utf-8

require 'spec_helper'

describe SaldoBancario do
  before(:each) do
    @user = Factory(:user)
    @banco = Factory(:banco)
    @empresa = Factory(:empresa)
    @attr = {:user_id => @user, :valor => 1356, :valor_currency => "EUR", :empresa_id => @empresa.id }
  end

  it "con atributos válidos debe crear una nueva instancia" do
    @banco.saldos_bancario.create!(@attr)
  end

  it "no permite asignar banco_id" do
    expect do
      attr = {:user_id => @user, :valor => 1356, :valor_currency => "EUR", :banco_id => @banco.id, :empresa_id => @empresa.id }
      SaldoBancario.create!(attr)
    end.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "el saldo bancario debe corresponderse con el banco" do
    @banco = Banco.new(:detalle => "Banco Galicia")
    @sb = @banco.saldos_bancario.build(@attr)
    @banco.save!
    @banco.reload
    @banco.saldos_bancario.first.banco_id.should == @banco.id
  end

  it "no debe guardarse el banco si hay un error en el saldo bancario" do
    @banco = Banco.new(:detalle => "Banco Galicia")
    @sb = @banco.saldos_bancario.build(@attr.merge(:empresa_id => nil))
    @banco.should_not be_valid
  end

  it "debe guardar el banco cuando se asigna un saldo bancario" do
    lambda do
      @banco = Banco.new(:detalle => "Banco Galicia")
      @banco.saldos_bancario.build(@attr)
      @banco.save!
    end.should change(Banco, :count).by(1)
  end

  it "debe guardar el saldo bancario" do
    lambda do
      @banco = Banco.new(:detalle => "Banco Galicia")
      @banco.saldos_bancario.build(@attr)
      @banco.save!
    end.should change(SaldoBancario, :count).by(1)
  end

  describe "debe responder a las propiedades" do

    before(:each) do
      @SaldoBancario = @banco.saldos_bancario.create!(@attr)
    end

    it "should have a user attribute" do
      @SaldoBancario.should respond_to(:user)
    end

    it "should have a valor attribute" do
      @SaldoBancario.should respond_to(:valor)
    end

    it "should have a valor_cents attribute" do
      @SaldoBancario.should respond_to(:valor_cents)
    end

    it "should have a valor_currency attribute" do
      @SaldoBancario.should respond_to(:valor_currency)
    end

    it "should have a detalle attribute" do
      @SaldoBancario.should respond_to(:detalle)
    end

    it "should have a detalle attribute" do
      @SaldoBancario.should respond_to(:tipo_de_movimiento)
    end

    it "should have the right associated user" do
      @SaldoBancario.user_id.should == @user.id
      @SaldoBancario.user.should == @user
    end

    it "should have the right associated banco" do
      @SaldoBancario.banco_id.should == @banco.id
      @SaldoBancario.banco.should == @banco
    end

    it "should have the right associated empresa" do
      @SaldoBancario.empresa_id.should == @empresa.id
      @SaldoBancario.empresa.should == @empresa
    end

    it "valor es del tipo money" do
      @SaldoBancario.valor == Money.new(@attr[:valor], @attr[:valor_currency])
    end

    it "no puede exisir dos saldos de la misma empresa y banco" do
      lambda {
        @banco.saldos_bancario.create!(@attr)
      }.should raise_error(ActiveRecord::RecordInvalid)

    end

    it "debe retornar el detalle correcto" do
      nombre = "Saldo Bancario Banco Frances Contable"
      @SaldoBancario.detalle.should == nombre
    end

    it "debe retornar el tipo_de_movimiento correcto" do
      @SaldoBancario.tipo_de_movimiento.should == PartidaContable::TIPODEMOVIMIENTO[:entrada]
    end

    describe "estado" do

      it "estados del saldo bancario" do
        SaldoBancario::ESTADOS[:activa].should == 1
        SaldoBancario::ESTADOS[:deshabilitada].should == 2
      end

      it "debe estar como activa" do
        @SaldoBancario.estado.should == SaldoBancario::ESTADOS[:activa]
      end

      it "debe ser requerido" do
        @SaldoBancario.estado = nil
        @SaldoBancario.should_not be_valid
      end

      it "no puede ser nulo" do
        @SaldoBancario.estado = nil
        @SaldoBancario.save
        @SaldoBancario.reload
        @SaldoBancario.estado.should == SaldoBancario::ESTADOS[:activa]
      end

      it "no debe aceptar valores" do
        @SaldoBancario.estado = 23
        @SaldoBancario.should_not be_valid
      end
    end
  end


  describe "validations" do

    it "should require a user id" do
      @banco.saldos_bancario.new(@attr.merge(:user_id => "")).should_not be_valid
    end

    it "should require a empresa id" do
      @banco.saldos_bancario.new(@attr.merge(:empresa_id => "")).should_not be_valid
    end

    it "should require number content" do
      @banco.saldos_bancario.new(@attr.merge(:valor => "a")).should_not be_valid
    end

    it "should require non nil content" do
      @banco.saldos_bancario.new(@attr.merge(:valor => nil)).should_not be_valid
    end

    it "should require nonblank content" do
      @banco.saldos_bancario.new(@attr.merge(:valor => "")).should_not be_valid
    end

    it "puede ser cero" do
      @banco.saldos_bancario.new(@attr.merge(:valor => 0)).should be_valid
    end

    it "puede ser cero con decimales" do
      @banco.saldos_bancario.new(@attr.merge(:valor => "0,00")).should be_valid
    end

    it "puede ser inferior a cero" do
      @banco.saldos_bancario.new(@attr.merge(:valor => "-0,01")).should be_valid
    end

    it "should require nonblank content" do
      @banco.saldos_bancario.new(@attr.merge(:valor_currency => "")).should_not be_valid
    end
  end

  describe "filtros" do
    it "debe obtener los saldos_bancario activos" do
      
    end
  end
end
