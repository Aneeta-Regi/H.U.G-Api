class SchoolsController < ApplicationController
  before_action :set_school, only: [:show, :update, :destroy, :students_by_year]
  before_action :authenticate_token!

  # GET /schools
  def index
    @schools = School.all

    render json: @schools
  end

  def index_school_no_student

    @schools = School.all

    render json: @schools.as_json(except: [:students])
  end

  # GET /schools/1
  def show
    render json: @school
  end

  # POST /schools
  def create

    @school = School.new(school_params)
    # temp fix till reporting and new districts feature complete
    @school.district_id = 1 if params[:district_id].nil?
    if @school.save
      render json: @school, status: :created, location: @school
    else
      render json: @school.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /schools/1
  def update
    if @school.update(school_params)
      render json: @school
    else
      render json: @school.errors, status: :unprocessable_entity
    end
  end

  # DELETE /schools/1

  #  remove any school ids from volunteers before deletion of record.
  def destroy
    volunteers = User.where("?=ANY(school_id)", @school.id)
    volunteers.each do |v|
      v.school_id.delete(@school.id)
      v.save
    end
    @school.destroy
  end

  # endpoint that sets up the drop down list for making a single student report.
  def students_by_year
    # school is set by set_school before action
    students = @school.students.select { |s| s.second_grade_year == params[:school_year] && s.control_group == false || s.third_grade_year == params[:school_year] && s.control_group == false || s.fifth_grade_year == params[:school_year] && s.control_group == false }
    # filter the students by year and activity type
    student_group = students.select { |s| s.why_inactive == 'graduated' || s.why_inactive.nil? || s.why_inactive == 'reinstated' }
    # create an object array so we can combine the names.
    list = []
    student_group.each do |s|
      list << {name: s.first_name + ' ' + s.s_last_name, id: s.id}
    end
    # check for no students in that school
      render json: list.as_json
  end

  private
    # Use callbacks to share common setup or constraints between actions.
  def set_school
    @school = School.find(params[:id])
  end

    # Only allow a trusted parameter "white list" through.
  def school_params
    params.require(:school).permit(:school_name, :school_phone, :address,
                                   :school_city, :school_state, :school_zip,
                                   :district_id, :principal_name,
                                   :vice_principal_name, :clarity_person_name,
                                   :clarity_person_phone, :clarity_person_second_phone,
                                   :clarity_person_email, :notes)
  end
end
