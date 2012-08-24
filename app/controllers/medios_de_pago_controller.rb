class MediosDePagoController < ApplicationController
  # GET /medios_de_pago
  # GET /medios_de_pago.json
  def index
    @medios_de_pago = MedioDePago.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @medios_de_pago }
    end
  end

  # GET /medios_de_pago/1
  # GET /medios_de_pago/1.json
  def show
    @medio_de_pago = MedioDePago.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @medio_de_pago }
    end
  end

  # GET /medios_de_pago/new
  # GET /medios_de_pago/new.json
  def new
    @medio_de_pago = MedioDePago.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @medio_de_pago }
    end
  end

  # GET /medios_de_pago/1/edit
  def edit
    @medio_de_pago = MedioDePago.find(params[:id])
  end

  # POST /medios_de_pago
  # POST /medios_de_pago.json
  def create
    @medio_de_pago = MedioDePago.new(params[:medio_de_pago])

    respond_to do |format|
      if @medio_de_pago.save
        format.html { redirect_to @medio_de_pago, notice: 'Medio de pago fue creado satisfactoriamente.' }
        format.json { render json: @medio_de_pago, status: :created, location: @medio_de_pago }
      else
        format.html { render action: "new" }
        format.json { render json: @medio_de_pago.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /medios_de_pago/1
  # PUT /medios_de_pago/1.json
  def update
    @medio_de_pago = MedioDePago.find(params[:id])

    respond_to do |format|
      if @medio_de_pago.update_attributes(params[:medio_de_pago])
        format.html { redirect_to @medio_de_pago, notice: 'Medio de pago fue actualizado satisfactoriamente.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @medio_de_pago.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /medios_de_pago/1
  # DELETE /medios_de_pago/1.json
  def destroy
    @medio_de_pago = MedioDePago.find(params[:id])
    @medio_de_pago.destroy

    respond_to do |format|
      format.html { redirect_to medios_de_pago_url }
      format.json { head :ok }
    end
  end
end
