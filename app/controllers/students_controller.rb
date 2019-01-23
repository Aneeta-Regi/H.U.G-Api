class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :show_web, :student_report, :update, :destroy, :list_undone, :start_session, :reactivate, :set_inactive]
  before_action :authenticate_token!

  # GET /students
  def index
    sort_by = params[:sort_by], :first_name || :first_name
    if @current_user.specialist || @current_user.persona == 'admin'
      @students = Student.where(active: true).where.not(grade: '5th').order(sort_by)
    else
      @students = Student.where(":uid = ANY(vol_ids)", uid: @current_user.id).where(active: true)
                         .or(Student.where(active: true, user_id: @current_user.id)).order(sort_by)
    end
    render json: @students.as_json(except: [:dra_records, :sessions])

  end

  def index_web
    sort_by = params[:sort_by], :first_name || :first_name
    if @current_user.specialist || @current_user.persona == 'admin'
      @students = Student.where(active: true).order(sort_by)
    else
      @students = Student.where(active: true, user_id: @current_user.id).order(sort_by)
      #  @students = Student.where(school_id: @current_user.school_id, active: true).order(sort_by)
    end
    render json: @students, each_serializer: StudentSerializerWeb

  end

  # list of all students that have been removed
  def index_inactive
    sort_by = params[:sort_by], :why_inactive, :first_name || :why_inactive, :first_name
    @students = Student.where(active: false).order(sort_by)

    render json: @students, each_serializer: StudentSerializerWeb
  end

  # GET /students/1
  def show
    if @current_user.specialist || @current_user.persona == 'admin'
      render json: @student, serializer: StudentSerializerWebShow
    else
      render json: @student
    end
  end

  def student_report
    render json: @student, serializer: StudentSerializerReport
  end

  # GET /students/1
  def show_web
    render json: @student, serializer: StudentSerializerWebShow
  end

  # list of lessons that a student has not attempted twice
  # this is an old method and is scheduled for deletion.
  def list_undone
    # grab all the lessons
    lessons = Lesson.all
    # establish the array to be rendered
    undone_lesson_list = []

    lessons.each do |lesson|
      unless Session.where(student_id: @student.id, lesson_id: lesson.id, second_attempt: true).exists?
        undone_lesson_list << lesson
      end
    end
    render json: undone_lesson_list.as_json(except: [:image, :sec_image, :summary, :created_at, :updated_at])

  end

  # list of lessons that a student has not attempted twice
  def start_session
    render json: @student, serializer: StudentSerializerSession
  end

  # POST /students
  def create
    if params[:control_group] || params[:grade] == '5th'
      volunteer = nil
    else
      volunteer = User.find(params[:user_id])
    end
    school = School.find(params[:school_id])
    @student = Student.new(student_params)
    update_params(volunteer, school)
    if @student.save
      render json: @student, status: :created, location: @student
    else
      render json: @student.errors, status: :unprocessable_entity
    end
  end

  def import_students
    @failed = []
    @success = []
    file = params[:file]
    # open the file and convert it to a spreadsheet Roo can use
    spreadsheet = Roo::Spreadsheet.open(file.path)
    # set the first row of the file to be the header attributes
    header = spreadsheet.row(1)
    # from the second row to the last row read the data and make students.
    (3..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      # set the school
      @school = School.find(params[:school_id])
      if row['Grade'] == '2nd' || row['Grade'] == '3rd' || row['Grade'] == '5th'
        # then its ok to do the work.
        if row['School Year'] == ' ' || row['School Year'].nil? || row['School Year'].empty?
          @failed << { name: row['Name'], message: 'School year is empty.' }
        else
          # set the school year based off the grade value
          row['Grade'] == '2nd' ? sgy = row['School Year'] : sgy = nil
          row['Grade'] == '3rd' ? tgy = row['School Year'] : tgy = nil
          row['Grade'] == '5th' ? fgy = row['School Year'] : fgy = nil
          # split the name into first and last
          first = row['Name'].partition(' ').first
          last = row['Name'].partition(' ').last
          # check if the student exists
          student_check = Student.where(first_name: first, s_last_name: last, school_id: params[:school_id])
          # guard against the student already existing
          if student_check.empty?
            # make a new student
            student = Student.new(first_name: first, s_last_name: last,
                                  school_id: params[:school_id], grade: row['Grade'],
                                  school_name: @school.school_name, class_name: row['Teacher'],
                                  num_other_programs: row['Pairing Number'], second_grade_year: sgy, third_grade_year: tgy, fifth_grade_year: fgy,
                                  control_group: row['Control Group Student'], clarity_person_name: @school.clarity_person_name,
                                  clarity_email: @school.clarity_person_email, clarity_phone: @school.clarity_person_phone )
            student.save
            @success << { name: row['Name'] }
          else
            # set the student row into the the failed hash
            @failed << { name: row['Name'], message: 'Student already exists.' }
          end
        end
      else
        @failed << { name: row['Name'], message: 'The grade is not correct' }
      end
    end
    @message = { number_successful: @success, failed: @failed }
    render json: @message
  end

  # PATCH/PUT /students/1
  def update
    # volunteer = User.find(params[:user_id])
    volunteer = params[:user_id].nil? ? nil : User.find(params[:user_id])
    school = School.find(params[:school_id])

    if @student.update(student_params)
      update_params(volunteer, school)
      @student.save
      if @current_user.specialist
        render json: @student, serializer: StudentSerializerWebShow
      else
        render json: @student
      end
    else
      render json: @student.errors, status: :unprocessable_entity
    end
  end

  # DELETE /students/1
  def destroy
    @student.active = false
    @student.save
  end

  def reactivate
    if @student.update(active: true, why_inactive: 'reinstated')
      render json: @student
    else
      render json: @student.errors, status: :unprocessable_entity
    end
  end

  def set_inactive
    params[:notes].nil? ? @student.update({active: false, why_inactive: params[:why_inactive]}) : @student.update({notes: @student.notes + params[:notes], active: false, why_inactive: params[:why_inactive]})
    render json: @student
  end

  def update_params(volunteer, school)
    if volunteer.nil?
      @student.vol_phone = ''
      @student.vol_name = ''
      @student.vol_email = ''
    else
      @student.vol_phone = volunteer.phone
      @student.vol_name = volunteer.first_name + ' ' + volunteer.last_name
      @student.vol_email = volunteer.email
    end
    @student.school_name = school.school_name
    @student.zip_code = school.school_zip
    @student.clarity_person_name = school.clarity_person_name
    @student.clarity_email = school.clarity_person_email
    @student.clarity_phone = school.clarity_person_phone
    @student.clarity_alt_phone = school.clarity_person_second_phone
  end

  # this is for graduating an entire class of students at a single school
  def advance_all_students
    @students = Student.where(active: true, school_id: params[:school_id])
    @students.each do |s|
      s.advance
    end
    message = @students.size.to_i + 'students have been advanced.'
    render json: message
  end

  # define the student actions and call the methods
  # ne note fucker.
  def student_actions
    case params[:thing_to_do]
      when 'Advance year'
        advance_students
      when 'Revert year'
        revert_students
      when 'Deactivate'
        mass_deactivate
      when 'Activate'
        mass_reactivate
      when 'Edit teacher'
        editing_teacher
      when 'Assign tutor'
        assigning_tutor
      when 'Add notes'
        adding_notes
      else
        message = { message: 'That action is not defined.' }
        render json: message, status: :unprocessable_entity
    end
  end

  # advance a group of students from one grade to the next
  # 3rd graders will be graduated.
  def advance_students
    unless params[:student_ids].empty?
      @students = Student.where(id: params[:student_ids])
      @students.each do |s|
        s.advance
      end
      message = { message: @students.size.to_s + 'students have been advanced.'}
    else
      message = {message: 'No student ids were received.'}
    end
    render json: message
  end

  # revert a list of students
  def revert_students
    unless params[:student_ids].empty?
      @students = Student.where(id: params[:student_ids])
      @students.each do |s|
        s.revert
      end
      message = {message: @students.size.to_s + 'students have been reverted.'}
    else
      message = {message: 'No student ids were received.'}
    end
    render json: message
  end

  # Deactivate a list of students
  # requires an array of students & why inactive
  def mass_deactivate
    unless params[:student_ids].empty?
      @students = Student.where(id: params[:student_ids])
      @students.each do |s|
        s.active = false
        s.why_inactive = params[:why_inactive]
        s.save
      end
      message = {message: @students.size.to_s + ' students have have been deactivated.'}
    else
      message = {message: 'No student ids were received.'}
    end
    render json: message
  end

  # Reactivate a list of students
  # requires an array of students & why inactive
  def mass_reactivate
    unless params[:student_ids].empty?
      @students = Student.where(id: params[:student_ids])
      @students.each do |s|
        s.active = true
        s.why_inactive = 'Reactivated'
        s.save
      end
      message = {message: @students.size.to_s + ' students have have been reactivated.'}
    else
      message = {message: 'No student ids were received.'}
    end
    render json: message
  end

  # edit the teacher of a list of students
  # requires student ids array and a class name.
    def editing_teacher
      unless params[:student_ids].empty?
        @students = Student.where(id: params[:student_ids])
        p @students.size
        @students.each do |s|
          p s.first_name
          s.class_name = params[:class_name]
          s.save
        end
        message = {message: @students.size.to_s + ' students have had their class name updated.'}
      else
        message = {message: 'No student ids were received.'}
      end
      render json: message
    end
  # assign a tutor to a list of students
  #requires student ids array and a user id.
  def assigning_tutor
    unless params[:student_ids].empty?
      @students = Student.where(id: params[:student_ids])
      tutor = User.find(params[:user_id])

      @students.each do |s|
        s.assign_tutor(tutor)
      end
      message = {message: @students.size.to_s + ' students have been assigned a new tutor.'}
    else
      message = {message: 'No student ids were received.'}
    end
    render json: message
  end

  # add notes to a list of students
  # requires student ids array and notes
  def adding_notes
    unless params[:student_ids].empty?
      @students = Student.where(id: params[:student_ids])
      @students.each do |s|
        s.add_note(params[:notes])
      end
      message = {message: @students.size.to_s + ' students have had their notes updated.'}
    else
      message = {message: 'No student ids were received.'}
    end
    render json: message
  end


  def average_mood
    @total_mood_one = 0
    @total_mood_two = 0
    students = Student.where(active: true)
    students.each do |s|
      average = Average.find_by_student_id(s.id)
      unless average.nil?
        @total_mood_one += average.mood_one
        @total_mood_two += average.mood_two
      end
    end
    engagement_averages = { mood_one: @total_mood_one, mood_two: @total_mood_two, num_students: students.size }
    render json: engagement_averages
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_student
    @student = Student.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def student_params
    params.require(:student).permit(:first_name, :class_name, :s_last_name, :school_id, :school_name, :user_id, :updated_at,
                                    :notes, :active, :why_inactive, :second_grade_year, :third_grade_year, :fifth_grade_year,
                                    :other_program_notes, :num_other_programs, :control_group,
                                    :graduated, :grade, :vol_name, :vol_email, :file, :vol_phone, :thing_to_do, :vol_ids => [], :student_ids => [])
  end


end
