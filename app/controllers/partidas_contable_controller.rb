class PartidasContableController < ApplicationController
  before_filter :inicializarVista

  def index
    @partidas_contable = PartidaContable.all
    respond_with(@partidas_contable)
  end

  def show
    @partida_contable = PartidaContable.find(params[:id])
    respond_with(@partida_contable)
  end

  def new
    @partida_contable = PartidaContable.new
    respond_with(@partida_contable)
  end

  def edit
    @partida_contable = PartidaContable.find(params[:id])
  end

  def create
    @partida_contable = PartidaContable.new(params[:partida_contable])
    @partida_contable.estado = "Activa"
    @partida_contable.referente_type = "Proveedor"
    @partida_contable.save
    respond_with(@partida_contable)
  end

  def update
    @partida_contable = PartidaContable.find(params[:id])
    @partida_contable.update_attributes(params[:partida_contable])
    respond_with(@partida_contable)
  end

  def destroy
    @partida_contable = PartidaContable.find(params[:id])
    @partida_contable.destroy
    respond_with(@partida_contable)
  end

  def dar_por_cumplida
    @partida_contable = PartidaContable.find(params[:id])
    @partida_contable.dar_por_cumplida
    if @partida_contable.save
      flash[:success] = "La partida contable se dio por cumplida correctamente"
      redirect_to partidas_contable_path(@pc)
    else
      flash.now[:failure] = "La partida contable no pudo darse por cumplida"
      render 'index'
    end
  end

  private

  def inicializarVista
    @empresas = Empresa.all
    @bancos = Banco.all
    @solicitantes = Solicitante.all
    @canales_de_solicitud = CanalDeSolicitud.all
    @rubros = Rubro.all
    @productos_trabajos = ProductoTrabajo.all
    @medios_de_pago = MedioDePago.all
    @referentes = Proveedor.all
    @motivos_de_baja_presupuestaria = MotivoDeBajaPresupuestaria.all
  end

end
