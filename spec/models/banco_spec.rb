#encoding: utf-8

require 'spec_helper'

describe Banco do
  before(:each) do
    @attr = {:detalle => "detalle1"}
  end

  it "con atributos válidos debe crear una nueva instancia" do
    Banco.create!(@attr)
  end

  it "debe tener el atributo detalle" do
    Banco.new.should respond_to(:detalle)
  end

  it "debe tener el atributo empresas_activas_asociadas" do
    Banco.new.should respond_to(:empresas_activas_asociadas)
  end

  it "debe tener el atributo empresas_activas_no_asociadas" do
    Banco.new.should respond_to(:empresas_activas_no_asociadas)
  end

  it "debe tener el atributo saldos_bancario_activos" do
    Banco.new.should respond_to(:saldos_bancario_activos)
  end

  it "debe tener el atributo saldos_bancario_deshabilitados" do
    Banco.new.should respond_to(:saldos_bancario_deshabilitados)
  end

  describe "validations" do
    it "should require a detalle" do
      Banco.new(@attr.merge(:detalle => "")).should_not be_valid
    end
  end

  describe "Asociación con empresa" do
    before do
      @banco = Banco.new
    end

    it "debe responder a empresas" do
      @banco.should respond_to(:empresas)
    end

    it "debe responder a saldos bancario" do
      @banco.should respond_to(:saldos_bancario)
    end

    describe "verificación de asociación" do
      before do
        @empresa1 = Factory(:empresa, :detalle => "TAESA", :estado => Empresa::ESTADOS[:activa])
        @empresa2 = Factory(:empresa, :detalle => "Chantaco", :estado => Empresa::ESTADOS[:deshabilitada])
        @empresa3 = Factory(:empresa, :detalle => "SuperFito", :estado => Empresa::ESTADOS[:activa])
        @empresa4 = Factory(:empresa, :detalle => "SuperGonza", :estado => Empresa::ESTADOS[:activa])
        @empresas = [@empresa1, @empresa2, @empresa3, @empresa4]
        @user = Factory(:user)
      end

      it "debe contener los bancos asociados" do
        @banco = Banco.create!(@attr)
        @empresas.each { |empresa|
          @banco.saldos_bancario.create!(:empresa_id => empresa.id, :user_id => @user, :valor => 4)
        }
        @banco.reload
        @banco.empresas.should == @empresas
      end

      it "debe guardar la asociación en una única operación" do
        @banco = Banco.new(@attr)
        @empresas.each { |empresa|
          @banco.saldos_bancario.build(:empresa_id => empresa.id, :user_id => @user, :valor => 4)
        }
        @banco.save!
        @banco.reload
        @banco.empresas.should == @empresas
      end

      it "no debe guardarse el banco si hay un error en la asociación" do
        @banco = Banco.new(@attr)
        @banco.saldos_bancario.build(:empresa_id => nil, :user_id => nil)
        @banco.save
        @banco.should_not be_valid
        @banco.should_not be_persisted
      end

      it "debe obtener las empresas activas asociadas al banco" do
        @banco = Banco.create!(:detalle => "Banco Galicia")
        @banco.saldos_bancario.create!(:empresa_id => @empresa3.id, :user_id => @user, :valor => 4)
        @banco.empresas_activas_asociadas.should =~ [@empresa3]
      end

      it "debe obtener las empresas activas asociadas al banco" do
        @banco = Banco.create!(:detalle => "Banco Galicia")
        @banco.empresas_activas_asociadas.should =~ []
      end

      it "debe obtener las empresas activas no asociadas al banco" do
        @banco = Banco.create!(:detalle => "Banco Galicia")
        @banco.saldos_bancario.create!(:empresa_id => @empresa3.id, :user_id => @user, :valor => 4)
        @banco.saldos_bancario.create!(:empresa_id => @empresa4.id, :user_id => @user, :valor => 4)
        @banco.empresas_activas_no_asociadas.should =~ [@empresa1]
      end

      it "debe obtener todas las empresas activas no asociadas al banco" do
        @banco = Banco.create!(:detalle => "Banco Galicia")
        @banco.empresas_activas_no_asociadas.should =~ [@empresa1, @empresa3, @empresa4]
      end

      it "debe obtener los saldos bancarios asociados activos" do
        @banco = Banco.create!(:detalle => "Banco Galicia")
        @sb1 = @banco.saldos_bancario.create!(:empresa_id => @empresa3.id, :user_id => @user, :valor => 4)
        @sb1.anular
        @sb1.save!
        @sb2 = @banco.saldos_bancario.create!(:empresa_id => @empresa4.id, :user_id => @user, :valor => 4)
        @banco2 = Banco.create!(:detalle => "Banco Frances")
        @banco2.saldos_bancario.create!(:empresa_id => @empresa1.id, :user_id => @user, :valor => 4)
        @banco.saldos_bancario_activos.should =~ [@sb2]
      end

      it "debe obtener los saldos bancarios asociados deshablitados" do
        @banco = Banco.create!(:detalle => "Banco Galicia")
        @sb1 = @banco.saldos_bancario.create!(:empresa_id => @empresa3.id, :user_id => @user, :valor => 4)
        @sb1.anular
        @sb1.save!
        @sb2 = @banco.saldos_bancario.create!(:empresa_id => @empresa4.id, :user_id => @user, :valor => 4)
        @banco2 = Banco.create!(:detalle => "Banco Frances")
        @banco2.saldos_bancario.create!(:empresa_id => @empresa1.id, :user_id => @user, :valor => 4)
        @banco.saldos_bancario_deshabilitados.should =~ [@sb1]        
      end

    end
  end
end
