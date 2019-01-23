class FeedbacksController < ApplicationController
  before_action :set_feedback, only: [:show, :update, :destroy]
  before_action :authenticate_token!

  # GET /feedbacks
  def index
    @feedbacks = Feedback.all.order('created_at DESC')
    render json: @feedbacks
  end

  # GET /feedbacks/1
  def show
    render json: @feedback
  end

  # POST /feedbacks
  def create
    @feedback = Feedback.new(feedback_params)
    set_extra_params
    if @feedback.save
      mood = @feedback.set_mood
      @feedback.mood < 3 ? bad_mail(mood) : FeedbackMailer.hug_thank_you(@feedback).deliver_now
      render json: @feedback, status: :created, location: @feedback
    else
      render json: @feedback.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /feedbacks/1
  def update
    if @feedback.update(feedback_params)
      render json: @feedback
    else
      render json: @feedback.errors, status: :unprocessable_entity
    end
  end

  # DELETE /feedbacks/1
  def destroy
    @feedback.destroy
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_feedback
    @feedback = Feedback.find(params[:id])
  end

  def bad_mail(mood)
    FeedbackMailer.hug_feedback_received(@feedback).deliver_now
    FeedbackMailer.feedback_email(@feedback, mood).deliver_now
  end

  def set_extra_params
    vol = User.find_by_email(params[:email])
    @feedback.vol_id = vol.id
    @feedback.vol_name = vol.first_name + ' ' + vol.last_name
  end

  # Only allow a trusted parameter "white list" through.
  def feedback_params
    params.require(:feedback).permit(:vol_name, :vol_id, :email, :mood, :comments, :resolution)
  end
end
