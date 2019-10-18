class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]

  # GET /messages
  # GET /messages.json
  def index
    @messages = policy_scope(Message)&.all
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
    authorize @message
  end

  # GET /messages/new
  def new
    @message = Message.new
    authorize @message
  end

  # GET /messages/1/edit
  def edit
    authorize @message
  end

  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(message_params)
    authorize @message

    respond_to do |format|
      if @message.save
        if params[:format].eql?('json')
          format.json { render status: 200, json: @message }
        else
          ActionCable.server.broadcast 'message_channel',
                                      message: message_render(@message)
        end   
      else
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /messages/1
  # PATCH/PUT /messages/1.json
  def update
    authorize @message
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    authorize @message
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url, notice: 'Message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def for_single_trip
    messages        = policy_scope(Message).where(trip_id: params[:trip_id])
    final_messages  = []
    
    messages.each do |message|
      json_messages                   = {}
      json_messages[:body]            = message.body
      json_messages[:created_at_time] = message.created_at.strftime('%H:%M %p')
      json_messages[:created_at_date] = message.created_at.strftime('%d %B')
      json_messages[:owner]           = (message.user == current_user)
      json_messages[:sender_name]     = message.user.full_name
      final_messages << json_messages
    end
    render json: final_messages
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = policy_scope(Message).find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:body, :trip_id, :user_id)
    end

    def message_render(message)
      render(partial: 'message', locals: { message: message })
    end
end
