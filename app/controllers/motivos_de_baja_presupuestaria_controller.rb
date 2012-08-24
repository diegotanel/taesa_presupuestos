class MotivosDeBajaPresupuestariaController < ApplicationController
  # GET /motivos_de_baja_presupuestaria
  # GET /motivos_de_baja_presupuestaria.json
  def index
    @motivos_de_baja_presupuestaria = MotivoDeBajaPresupuestaria.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @motivos_de_baja_presupuestaria }
    end
  end

  # GET /motivos_de_baja_presupuestaria/1
  # GET /motivos_de_baja_presupuestaria/1.json
  def show
    @motivo_de_baja_presupuestaria = MotivoDeBajaPresupuestaria.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @motivo_de_baja_presupuestaria }
    end
  end

  # GET /motivos_de_baja_presupuestaria/new
  # GET /motivos_de_baja_presupuestaria/new.json
  def new
    @motivo_de_baja_presupuestaria = MotivoDeBajaPresupuestaria.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @motivo_de_baja_presupuestaria }
    end
  end

  # GET /motivos_de_baja_presupuestaria/1/edit
  def edit
    @motivo_de_baja_presupuestaria = MotivoDeBajaPresupuestaria.find(params[:id])
  end

  # POST /motivos_de_baja_presupuestaria
  # POST /motivos_de_baja_presupuestaria.json
  def create
    @motivo_de_baja_presupuestaria = MotivoDeBajaPresupuestaria.new(params[:motivo_de_baja_presupuestaria])

    respond_to do |format|
      if @motivo_de_baja_presupuestaria.save
        format.html { redirect_to @motivo_de_baja_presupuestaria, notice: 'Motivo de baja presupuestaria fue creado satisfactoriamente' }
        format.json { render json: @motivo_de_baja_presupuestaria, status: :created, location: @motivo_de_baja_presupuestaria }
      else
        format.html { render action: "new" }
        format.json { render json: @motivo_de_baja_presupuestaria.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /motivos_de_baja_presupuestaria/1
  # PUT /motivos_de_baja_presupuestaria/1.json
  def update
    @motivo_de_baja_presupuestaria = MotivoDeBajaPresupuestaria.find(params[:id])

    respond_to do |format|
      if @motivo_de_baja_presupuestaria.update_attributes(params[:motivo_de_baja_presupuestaria])
        format.html { redirect_to @motivo_de_baja_presupuestaria, notice: 'Motivo de baja presupuestaria fue actualizado satisfactoriamente' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @motivo_de_baja_presupuestaria.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /motivos_de_baja_presupuestaria/1
  # DELETE /motivos_de_baja_presupuestaria/1.json
  def destroy
    @motivo_de_baja_presupuestaria = MotivoDeBajaPresupuestaria.find(params[:id])
    @motivo_de_baja_presupuestaria.destroy

    respond_to do |format|
      format.html { redirect_to motivos_de_baja_presupuestaria_url }
      format.json { head :ok }
    end
  end
end
