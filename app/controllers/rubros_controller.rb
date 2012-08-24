class RubrosController < ApplicationController
  # GET /rubros
  # GET /rubros.json
  def index
    @rubros = Rubro.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @rubros }
    end
  end

  # GET /rubros/1
  # GET /rubros/1.json
  def show
    @rubro = Rubro.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @rubro }
    end
  end

  # GET /rubros/new
  # GET /rubros/new.json
  def new
    @rubro = Rubro.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @rubro }
    end
  end

  # GET /rubros/1/edit
  def edit
    @rubro = Rubro.find(params[:id])
  end

  # POST /rubros
  # POST /rubros.json
  def create
    @rubro = Rubro.new(params[:rubro])

    respond_to do |format|
      if @rubro.save
        format.html { redirect_to @rubro, notice: 'Rubro fue creado satisfactoriamente' }
        format.json { render json: @rubro, status: :created, location: @rubro }
      else
        format.html { render action: "new" }
        format.json { render json: @rubro.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /rubros/1
  # PUT /rubros/1.json
  def update
    @rubro = Rubro.find(params[:id])

    respond_to do |format|
      if @rubro.update_attributes(params[:rubro])
        format.html { redirect_to @rubro, notice: 'Rubro fue actualizado satisfactoriamente' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @rubro.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rubros/1
  # DELETE /rubros/1.json
  def destroy
    @rubro = Rubro.find(params[:id])
    @rubro.destroy

    respond_to do |format|
      format.html { redirect_to rubros_url }
      format.json { head :ok }
    end
  end
end
