class BusinessstatusesController < ApplicationController
  before_action :set_businessstatus, only: [:show, :edit, :update, :destroy]

  # GET /businessstatuses
  # GET /businessstatuses.json
  def index
    @businessstatuses = Businessstatus.all
  end

  # GET /businessstatuses/1
  # GET /businessstatuses/1.json
  def show
  end

  # GET /businessstatuses/new
  def new
    @businessstatus = Businessstatus.new
  end

  # GET /businessstatuses/1/edit
  def edit
  end

  # POST /businessstatuses
  # POST /businessstatuses.json
  def create
    @businessstatus = Businessstatus.new(businessstatus_params)

    respond_to do |format|
      if @businessstatus.save
        format.html { redirect_to @businessstatus, notice: 'Businessstatus was successfully created.' }
        format.json { render action: 'show', status: :created, location: @businessstatus }
      else
        format.html { render action: 'new' }
        format.json { render json: @businessstatus.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /businessstatuses/1
  # PATCH/PUT /businessstatuses/1.json
  def update
    respond_to do |format|
      if @businessstatus.update(businessstatus_params)
        format.html { redirect_to @businessstatus, notice: 'Businessstatus was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @businessstatus.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /businessstatuses/1
  # DELETE /businessstatuses/1.json
  def destroy
    @businessstatus.destroy
    respond_to do |format|
      format.html { redirect_to businessstatuses_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_businessstatus
      @businessstatus = Businessstatus.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def businessstatus_params
      params.require(:businessstatus).permit(:name)
    end
end
