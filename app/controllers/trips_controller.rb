class TripsController < ApplicationController
  before_action :set_trip, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, except: [:new, :create, :edit, :update, :destroy]
  # GET /trips
  # GET /trips.json
  def index
    set_index_results
    # if params[:id].present?
    #   @trips = Trip.where('id < ? AND kind = ?', params[:id], kind).limit(8)
    # else
      # @trips = Trip.all
    # end

    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /trips/1
  # GET /trips/1.json
  def show
    track_action("View", @trip)
    @messages = @trip.messages
    @riders   = @trip.riders
  end

  # GET /trips/new
  def new
    redirect_to new_vehicle_path, notice: I18n.t('trips.new.no_vehicle') unless current_user.vehicles.any?
    @trip = Trip.new
    authorize @trip
  end

  # GET /trips/1/edit
  def edit
    authorize @trip
  end

  # POST /trips
  # POST /trips.json
  def create
    @trip      = Trip.new(trip_params)
    @trip.user = current_user
    authorize @trip
    respond_to do |format|
      if @trip.save
        format.html { redirect_to @trip, notice: 'Trip was successfully created.' }
        format.json { render :show, status: :created, location: @trip }
      else
        format.html { render :new }
        format.json { render json: @trip.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trips/1
  # PATCH/PUT /trips/1.json
  def update
    authorize @trip
    respond_to do |format|
      if @trip.update(trip_params)
        format.html { redirect_to @trip, notice: 'Trip was successfully updated.' }
        format.json { render :show, status: :ok, location: @trip }
      else
        format.html { render :edit }
        format.json { render json: @trip.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trips/1
  # DELETE /trips/1.json
  def destroy
    authorize @trip
    @trip.destroy
    respond_to do |format|
      format.html { redirect_to trips_url, notice: 'Trip was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trip
      @trip = policy_scope(Trip.friendly).find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trip_params
      params.require(:trip).permit(:kind, :start_location, :end_location, :seats, :price, :vehicle_id, :plan_id, :event_id, :approved, :departure_times, :return_times, :round_trip)
      # params.require(:trip).permit(:kind, :start_location, :end_location, :seats, :price, :vehicle_id, :plan_id, :event_id, :approved, :departure_times, :return_times, :round_trip, :description)
    end

    def set_index_results
      # if params[:id].present?
      #   set_based_on_kind(params[:kind])
      if params[:keyword].present?
        trips                 = policy_scope(Trip).search(params[:keyword].split('-').join(' '))
        @daily_work_trips     = trips.select {|trip| trip.kind=='daily_work'}
        @social_trips         = trips.select {|trip| trip.kind=='social_events'}
        @cross_province_trips = trips.select {|trip| trip.kind=='cross_province_home'}
      else
        @daily_work_trips     = policy_scope(Trip).where(kind: 'daily_work')
        @social_trips         = policy_scope(Trip).where(kind: 'social_events')
        @cross_province_trips = policy_scope(Trip).where(kind: 'cross_province_home')
      end
    end

    def set_based_on_kind kind
      if kind.eql?('daily_work')
        @trips = Trip.where('id < ? AND kind = ?', params[:id], kind).order(:created_at)
      elsif kind.eql?('social_events')
        @trips = Trip.where('id < ? AND kind = ?', params[:id], kind).order(:created_at)
      elsif kind.eql?('cross_province_home')
        @trips  = Trip.where('id < ? AND kind = ?', params[:id], kind).order(:created_at)
      end
    end
end
