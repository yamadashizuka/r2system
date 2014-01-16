class EnginemodelsController < ApplicationController
  before_action :set_enginemodel, only: [:show, :edit, :update, :destroy]

  # GET /enginemodels
  # GET /enginemodels.json
  def index
    @enginemodels = Enginemodel.all
  end

  # GET /enginemodels/1
  # GET /enginemodels/1.json
  def show
  end

  # GET /enginemodels/new
  def new
    @enginemodel = Enginemodel.new
  end

  # GET /enginemodels/1/edit
  def edit
  end

  # POST /enginemodels
  # POST /enginemodels.json
  def create
    @enginemodel = Enginemodel.new(enginemodel_params)

    respond_to do |format|
      if @enginemodel.save
        format.html { redirect_to @enginemodel, notice: 'Enginemodel was successfully created.' }
        format.json { render action: 'show', status: :created, location: @enginemodel }
      else
        format.html { render action: 'new' }
        format.json { render json: @enginemodel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /enginemodels/1
  # PATCH/PUT /enginemodels/1.json
  def update
    respond_to do |format|
      if @enginemodel.update(enginemodel_params)
        format.html { redirect_to @enginemodel, notice: 'Enginemodel was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @enginemodel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /enginemodels/1
  # DELETE /enginemodels/1.json
  def destroy
    @enginemodel.destroy
    respond_to do |format|
      format.html { redirect_to enginemodels_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_enginemodel
      @enginemodel = Enginemodel.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def enginemodel_params
      params.require(:enginemodel).permit(:modelcode, :name)
    end
end
