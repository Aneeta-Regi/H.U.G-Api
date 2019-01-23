class AbsencesController < ApplicationController
  before_action :authenticate_token!
  before_action :set_absence, only: [:show, :update, :destroy]

  # GET /absences
  def index
    @absences = Absence.all

    render json: @absences
  end

  # GET /absences/1
  def show
    render json: @absence
  end

  # POST /absences
  def create
    @absence = Absence.new(student_id: params[:student_id], lesson_id: params[:lesson_id],
                           vol_id: params[:vol_id], date: params[:date])
    lesson = Lesson.find(params[:lesson_id])
    user = User.find(params[:vol_id])
    @absence.recorded_by = user.first_name + ' ' + user.last_name
    @absence.lesson_identifier = lesson.lesson_identifier
    @absence.lesson_name = lesson.lesson_name

    if @absence.save
      # hand this off to the model and see if we have 3 absences
      @absence.check_number(@absence.student_id)
      render json: @absence, status: :created, location: @absence
    else
      render json: @absence.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /absences/1
  def update
    if @absence.update(absence_params)
      lesson = Lesson.find(params[:lesson_id])
      user = User.find(params[:vol_id])
      @absence.recorded_by = user.first_name + ' ' + user.last_name
      @absence.lesson_identifier = lesson.lesson_identifier
      @absence.lesson_name = lesson.lesson_name
      @absence.save
      render json: @absence
    else
      render json: @absence.errors, status: :unprocessable_entity
    end
  end

  # DELETE /absences/1
  def destroy
    @absence.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_absence
      @absence = Absence.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def absence_params
      params.require(:absence).permit(:student_id, :date, :vol_id, :lesson_id, :lesson_name, :lesson_identifier, :recorded_by)
    end
end
