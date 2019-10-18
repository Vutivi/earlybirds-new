class LeadsController < ApplicationController
  before_action :set_lead, only: [:show, :edit, :update, :destroy]

  # GET /leads
  # GET /leads.json
  def index
    @leads = scope(Lead).all
  end

  # GET /leads/1
  # GET /leads/1.json
  def show
    authorize @lead
  end

  # GET /leads/new
  def new
    @lead = Lead.new
    authorize @lead
  end

  # GET /leads/1/edit
  def edit
    authorize @lead
  end

  # POST /leads
  # POST /leads.json
  def create
    @lead = Lead.new(lead_params)
    authorize @lead

    respond_to do |format|
      if @lead.save
        format.html { redirect_to request.referrer, notice: I18n.t('lead.create.success') }
        format.json { render :show, status: :created, location: @lead }
      else
        format.html { redirect_to request.referrer, notice: @lead.errors.full_messages.join }
        format.json { render json: @lead.errors, status: :unprocessable_entity }
      end
    end
  end

  def for_single_trip
    @trip  = policy_scope(Trip).find(params[:trip_id])
    @leads  = @trip.leads.paginate(page: params[:page], per_page: 10)
    authorize @leads
    # respond_to do |format|
    #   format.json { render json: leads }
    # end
  end

  # PATCH/PUT /leads/1
  # PATCH/PUT /leads/1.json
  def update
    authorize @lead
    respond_to do |format|
      if @lead.update(lead_params)
        format.html { redirect_to @lead, notice: 'Lead was successfully updated.' }
        format.json { render :show, status: :ok, location: @lead }
      else
        format.html { render :edit }
        format.json { render json: @lead.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /leads/1
  # DELETE /leads/1.json
  def destroy
    authorize @lead
    @lead.destroy
    respond_to do |format|
      format.html { redirect_to leads_url, notice: 'Lead was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lead
      @lead = policy_scope(Lead).find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lead_params
      params.require(:lead).permit(:trip_id, :first_name, :last_name, :cellphone, :email)
    end
end
