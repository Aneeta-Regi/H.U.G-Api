class AveragesController < ApplicationController
  before_action :set_average, only: [:show, :update, :destroy]

  # GET /averages
  def index
    @averages = Average.all

    render json: @averages
  end

  # GET /averages/1
  def show
    render json: @average
  end

  # POST /averages
  def create
    @average = Average.new(average_params)

    if @average.save
      render json: @average, status: :created, location: @average
    else
      render json: @average.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /averages/1
  def update
    if @average.update(average_params)
      render json: @average
    else
      render json: @average.errors, status: :unprocessable_entity
    end
  end

  def average_acumen
    school_id = params[:school_id]
    school = School.find(params[:school_id])
    students = Student.where(school_id: school_id)
    # break out students by grade level

    # setup simple variables.
    @dont_count = 0
    @acumen_total = 0

    # process the 2nd graders
    students.each do |student|
      average = Average.find_by_student_id(student.id)
      if average.nil?
        @dont_count += @dont_count
      else
      @acumen_total = average.acumen_two + @acumen_total
      end
    end

    # process the 3rd graders

    # take an average of the school as a total.
    acumen_average = 100 - (@acumen_total / (students.size - @dont_count))
    average_acumen = { school_name: school.school_name, number_of_students: students.size, acumen_average: acumen_average }
    render json: average_acumen.as_json
  end

  # DELETE /averages/1
  def destroy
    @average.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_average
      @average = Average.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def average_params
      params.require(:average).permit(:school_id, :acumen_one, :acumen_two, :mood_one, :mood_two, :time_one, :time_two, :student_id)
    end
end
