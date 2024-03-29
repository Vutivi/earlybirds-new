class EventsController < ApplicationController
  include TinifyImage
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  after_action :attach_image, only: [:create, :update]
  skip_before_action :authenticate_user!, except: [:new, :create, :edit, :update, :destroy]

  # GET /events
  # GET /events.json
  def index
    @events = policy_scope(Event).all
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event_trips   = @event.trips
    @related_trips = policy_scope(Trip).where(kind: 'social_events').where.not(event: @event)
    
  end

  # GET /events/new
  def new
    @event = Event.new
    authorize @event
  end

  # GET /events/1/edit
  def edit
    authorize @event
  end

  # POST /events
  # POST /events.json
  def create
    @event       = Event.new(event_params)
    authorize @event

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
   authorize @event

    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    authorize @event
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = policy_scope(Event.friendly).find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:name, :description, :address, :start_time, :end_time, :ticket_link, :expired, :category_id, :image)
    end

    def attach_image
      return unless params[:event][:image].present?
      image = open(tinify(params[:event][:image].tempfile))
      @event.image.attach(io: image, filename: "#{@event.name}-cover.png")
      # @event.image.attach(io: params[:event][:image], filename: "#{@event.name}-cover.png")
    end
end
