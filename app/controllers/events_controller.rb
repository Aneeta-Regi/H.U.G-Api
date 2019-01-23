class EventsController < ApplicationController
  before_action :set_event, only: [:show, :update, :destroy]

  # GET /events
  def index
    @events = Event.where("start_date >= ?", Time.zone.now.beginning_of_day)

    render json: @events
  end

  # GET /events/1
  def show
    render json: @event
  end

  def by_school
    @events = Event.where(school_id: params[:school_id])
    render json: @events
  end

  # POST /events
  def create
    @event = Event.new(event_params)
    school = School.find(@event.school_id)
    @event.school_name = school.school_name

    if @event.save
      render json: @event, status: :created, location: @event
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /events/1
  def update
    if @event.update(event_params)
      render json: @event
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  # DELETE /events/1
  def destroy
    @event.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def event_params
      params.require(:event).permit(:event_name, :start_date, :url, :image, :school_id, :school_name, :description, :address, :city, :state, :zip, :label, :end_date)
    end
end
