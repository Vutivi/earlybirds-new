class RidersController < ApplicationController
  before_action :set_rider, only: [:show, :edit, :update, :destroy]

  # GET /riders
  # GET /riders.json
  def index
    @riders = policy_scope(Rider).all
  end

  # GET /riders/1
  # GET /riders/1.json
  def show
    authorize @rider
  end

  # GET /riders/new
  def new
    @rider = Rider.new
    authorize @rider
  end

  # GET /riders/1/edit
  def edit
    authorize @rider
  end

  # POST /riders
  # POST /riders.json
  def create
    @rider      = Rider.new(rider_params)
    authorize @rider

    respond_to do |format|
      if @rider.save
        format.html { redirect_to @rider, notice: I18n.t('rider.create.success') }
        format.json { render json: @rider }
      else
        format.html { render :new }
        format.json { render json: @rider.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /riders/1
  # PATCH/PUT /riders/1.json
  def update
    authorize @rider
    respond_to do |format|
      if @rider.update(rider_params)
        format.html { redirect_to @rider, notice: 'Rider was successfully updated.' }
        format.json { render :show, status: :ok, location: @rider }
      else
        format.html { render :edit }
        format.json { render json: @rider.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /riders/1
  # DELETE /riders/1.json
  def destroy
    authorize @rider
    @rider.destroy
    respond_to do |format|
      format.html { redirect_to riders_url, notice: I18n.t('rider.destroy.success') }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rider
      @rider = policy_scope(Rider).find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rider_params
      params.require(:rider).permit(:user_id, :trip_id)
    end
end
