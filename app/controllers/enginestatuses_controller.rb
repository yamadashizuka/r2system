class EnginestatusesController < ApplicationController
  before_action :set_enginestatus, only: [:show, :edit, :update, :destroy]

  # GET /enginestatuses
  # GET /enginestatuses.json
  def index
    @enginestatuses = Enginestatus.all
  end

  # GET /enginestatuses/1
  # GET /enginestatuses/1.json
  def show
  end

  # GET /enginestatuses/new
  def new
    @enginestatus = Enginestatus.new
  end

  # GET /enginestatuses/1/edit
  def edit
  end

  # POST /enginestatuses
  # POST /enginestatuses.json
  def create
    @enginestatus = Enginestatus.new(enginestatus_params)

    respond_to do |format|
      if @enginestatus.save
        format.html { redirect_to @enginestatus, notice: 'Enginestatus was successfully created.' }
        format.json { render action: 'show', status: :created, location: @enginestatus }
      else
        format.html { render action: 'new' }
        format.json { render json: @enginestatus.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /enginestatuses/1
  # PATCH/PUT /enginestatuses/1.json
  def update
    respond_to do |format|
      if @enginestatus.update(enginestatus_params)
        format.html { redirect_to @enginestatus, notice: 'Enginestatus was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @enginestatus.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /enginestatuses/1
  # DELETE /enginestatuses/1.json
  def destroy
    @enginestatus.destroy
    respond_to do |format|
      format.html { redirect_to enginestatuses_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_enginestatus
      @enginestatus = Enginestatus.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def enginestatus_params
      params.require(:enginestatus).permit(:name)
    end
end
