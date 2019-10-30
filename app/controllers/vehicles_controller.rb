class VehiclesController < ApplicationController
  include TinifyImage

  before_action :set_vehicle, only: [:show, :edit, :update, :destroy]
  after_action  :attach_image, only: [:create, :update]
  # after_action  :update_role, only: [:create, :update]
  # before_action :require_vehicle_images, only: %i[update create]

  # GET /vehicles
  # GET /vehicles.json
  def index
    @vehicles = policy_scope(Vehicle).where(user: current_user)
  end

  # GET /vehicles/1
  # GET /vehicles/1.json
  def show
    authorize @vehicle
  end

  # GET /vehicles/new
  def new
    @vehicle = Vehicle.new
    authorize @vehicle
  end

  # GET /vehicles/1/edit
  def edit
    authorize @vehicle
  end

  # POST /vehicles
  # POST /vehicles.json
  def create
    @vehicle      = Vehicle.new(vehicle_params)
    @vehicle.user = current_user
    authorize @vehicle
      
    respond_to do |format|
      if @vehicle.save
        format.html { redirect_to new_trip_path, notice: 'Vehicle was successfully created. You can now create your ride' }
        format.json { render :show, status: :created, location: @vehicle }
      else
        format.html { render :new }
        format.json { render json: @vehicle.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vehicles/1
  # PATCH/PUT /vehicles/1.json
  def update
    authorize @vehicle
    respond_to do |format|
      if @vehicle.update(vehicle_params)
        format.html { redirect_to @vehicle, notice: 'Vehicle was successfully updated.' }
        format.json { render :show, status: :ok, location: @vehicle }
      else
        format.html { render :edit }
        format.json { render json: @vehicle.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vehicles/1
  # DELETE /vehicles/1.json
  def destroy
    @vehicle.destroy
    respond_to do |format|
      format.html { redirect_to vehicles_url, notice: 'Vehicle was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vehicle
      @vehicle = policy_scope(Vehicle).find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def vehicle_params
      params.require(:vehicle).permit(:make, :model, :user_id, :licence_plate, :color, :is_verified, :image)
    end

    def attach_image
      return unless params[:vehicle][:image].present?
      image = open(tinify(params[:vehicle][:image].tempfile))
      @vehicle.image.attach(io: image, filename: "#{@vehicle.make}-#{@vehicle.id}.png")
    end

    def update_role
      current_user.update!(role: "driver", cellphone: '0000000000') unless current_user.driver?
    end
end
