class SessionsController < ApplicationController
  before_action :set_session, only: [:show, :update, :destroy, :show_sessions]
  before_action :authenticate_token!
  before_action :check_permission, only: [:update]
  before_action :set_lesson, only: [:create_new, :update]
  before_action :set_user, only: [:create_new, :update]
  before_action :set_student, only: [:create_new, :update]

  # GET /sessions
  def index
    @sessions = Session.all

    render json: @sessions, each_serializer: SessionSerializer
   # render json: @sessions
  end

  # GET /sessions/1
  def show
    render json: @session
  end

  def show_sessions
    session_two = Session.where(lesson_id: @session.lesson_id, student_id: @session.student_id, second_attempt: true)
    lesson = Lesson.find(@session.lesson_id)
    vol_id = set_vol
    feedback = Feedback.where(session_id: session_two[0].id)
    vol_mood = feedback.empty? ? nil : feedback[0].mood

    sessions = { student_id: @session.student_id, lesson_id: @session.lesson_id,
                 lesson_identifier: @session.lesson_identifier, lesson_title: lesson.lesson_name,
                 lesson_grade: lesson.grade_level, lesson_total_word_count: lesson.total_word, recorded_by: @session.recorded_by,
                 vol_id: vol_id, date: @session.date, session_one_id: @session.id, mood_one: @session.student_mood,
                 acumen_one: @session.acumen, words_missed_one: @session.word_missed, acumen_two: session_two[0].acumen,
                 session_two_id: session_two[0].id, mood_two: session_two[0].student_mood, words_missed_two: session_two[0].word_missed,
                 num_words_learned: session_two[0].num_words_learned,
                 comments: session_two[0].comments, vol_mood: vol_mood }

    render json: sessions.as_json
  end

  def set_vol
    f_name = @session.recorded_by.partition(' ').first
    l_name = @session.recorded_by.partition(' ').last
    vol = User.where(first_name: f_name, last_name: l_name)
    vol_id = vol.empty? ? nil : vol[0].id
    vol_id
  end

  # POST /sessions
  # scheduled for deletion this is bad.
  def create
    # find the lesson so we can have the total number of words
    lesson = Lesson.find(params[:lesson_id])

    # set the acumen and check for 0 words missed.
    if params[:word_missed] == 0
      acumen = 0
    else
      acumen = (100 * (params[:word_missed].to_f / lesson.total_word)).round(2)
    end
    @session = Session.new(session_params)
    # add in the acumen score
    @session.acumen = acumen
    # add in the lesson identifier
    # lesson = Lesson.find(@session.lesson_id)
    @session.lesson_identifier = lesson.lesson_identifier
    # check if a session for this lesson already exists
    unless Session.where(lesson_id: params[:lesson_id], student_id: params[:student_id]).exists?
      @session.comments = ''
      @session.num_words_learned = ''
      # if not then just save
      @session.save
      # call the averages
      averages
      render json: @session, status: :created, location: @session
    else
      # we check if this is actually a third attempt
      unless Session.where(lesson_id: params[:lesson_id], student_id: params[:student_id], second_attempt: true).exists?
        # set second attempt flag to true
        @session.second_attempt = true
        @session.save
        averages
        render json: @session, status: :created, location: @session
      else
        render json: {errors: ResponseHelper::THIRD_SESSION_ERROR}, status: :unprocessable_entity
      end
    end
  end

  def create_new
    # check for existing second session attempt on this lesson
    unless Session.where(lesson_id: params[:lesson_id], student_id: params[:student_id], second_attempt: true).exists?
      # create session one send in attributes
      session = make_session(params[:words_missed_one], params[:mood_one])
      # save session one
      session.save
      # create second session
      session_two = make_session(params[:words_missed_two], params[:mood_two])
      # set session second attempt to true comments and words learned
      session_two.second_attempt = true
      session_two.num_words_learned = params[:num_words_learned]
      session_two.comments = params[:comments]
      session_two.save
      # call make feedback
      make_feedback( session_two )
      averages
      render json: @session, status: :created, location: @session
    else
      render json: {errors: ResponseHelper::THIRD_SESSION_ERROR}, status: :unprocessable_entity
    end
  end

  def make_session(words_missed, mood)
    # lets set up the recorded by name based of the user.
    recorded_by = @user.first_name + ' ' + @user.last_name
    student_name = @student.first_name + ' ' + @student.s_last_name
    set_school_year(params[:date])
    session = Session.create(student_id: params[:student_id], lesson_id: params[:lesson_id],
                             lesson_identifier: @lesson.lesson_identifier, recorded_by: recorded_by,
                             date: params[:date], student_name: student_name, grade_level: @lesson.grade_level, school_id: @student.school_id,
                             school_name: @student.school_name, school_year: @set_school_year, vol_id: @user.id)
    # call new acumen method
    session.acumen = set_acumen(words_missed, @lesson.total_word)
    session.student_mood = mood
    session.word_missed = words_missed
    # return session
    session
  end

  def set_acumen(words_missed, total_words)
    if words_missed == 0
      acumen = 0
    else
      acumen = (100 * (words_missed.to_f / total_words)).round(2)
    end
    acumen
  end

  def make_feedback(session_two)
    recorded_by = @user.first_name + ' ' + @user.last_name
    feedback = Feedback.create(vol_name: recorded_by,
                               vol_id: @user.id, email: @user.email,
                               mood: params[:vol_mood], comments: params[:comments],
                               session_id: session_two.id)
    feedback.save
  end

  def update_feedback(session_two)
    feedback = Feedback.find_by_session_id(session_two.id)
    if feedback.nil?
      make_feedback(session_two)
    else
      feedback.mood = params[:vol_mood]
      feedback.comments = params[:comments]
      feedback.vol_id = @user.id
      feedback.save
    end
  end

  # PATCH/PUT /sessions/1
  def update
    session_two = Session.where(lesson_id: @session.lesson_id, student_id: @session.student_id, second_attempt: true)
    @second_session = session_two[0]
    update_second_session
    update_feedback(@second_session)
    @session.update(session_params)
    @session.date = params[:date]
    @session.word_missed = params[:words_missed_one]
    @session.acumen = set_acumen(params[:words_missed_one], @lesson.total_word)
    @session.student_mood = params[:mood_one]
    @session.vol_id = @user.id
    @session.recorded_by = @user.first_name + ' ' + @user.last_name
    averages
    if @session.save
      render json: @session
    else
      render json: @session.errors, status: :unprocessable_entity
    end
  end

  def update_second_session
    @second_session.update(session_params)
    @second_session.word_missed = params[:words_missed_two]
    @second_session.date = params[:date]
    @second_session.acumen = set_acumen(params[:words_missed_two], @lesson.total_word)
    @second_session.student_mood = params[:mood_two]
    @second_session.vol_id = @user.id
    @second_session.recorded_by = @user.first_name + ' ' + @user.last_name
    @second_session.save
  end

  # DELETE /sessions/1
  def destroy
    @session.destroy
    averages
  end

  def averages

    # create an array of sessions with that student id
    @sessions = Session.where(student_id: params[:student_id])
    # create two new arrays that check if second attempt is not true
    first_sessions = @sessions.select {|s| !s.second_attempt}
    second_sessions = @sessions.select {|s| s.second_attempt}
    # use the reduce command to add each type of attribute for the array. Remember to have the 0 after reduce to initalize the variable as an integer
    # first_fluency_total = first_sessions.reduce(0) {|sum, s| sum += s.time}
    first_acumen_total = first_sessions.reduce(0) {|sum, s| sum += s.acumen}
    first_mood_total = first_sessions.reduce(0) {|sum, s| sum += s.student_mood}

    # first_fluency_avg = first_fluency_total / first_sessions.size
    first_acumen_avg = first_acumen_total / first_sessions.size
    first_mood_avg = first_mood_total / first_sessions.size

    if second_sessions.size > 0
      # second_fluency_total = second_sessions.reduce(0) {|sum, s| sum += s.time}
      second_acumen_total = second_sessions.reduce(0) {|sum, s| sum += s.acumen}
      second_mood_total = second_sessions.reduce(0) {|sum, s| sum += s.student_mood}

      # second_fluency_avg = second_fluency_total / second_sessions.size
      second_acumen_avg = second_acumen_total / second_sessions.size
      second_mood_avg = second_mood_total / second_sessions.size
    end

    # set the average
    average = Average.find_by(student_id: params[:student_id]) || Average.new

    average.student_id = params[:student_id]

    # average.time_one = first_fluency_avg
    average.acumen_one = first_acumen_avg
    average.mood_one = first_mood_avg

    # average.time_two = second_fluency_avg
    average.acumen_two = second_acumen_avg
    average.mood_two = second_mood_avg

    average.save!
  end

  def set_lesson
    @lesson = Lesson.find(params[:lesson_id])
  end

  def set_user
    if params[:vol_id].nil? || params[:vol_id].zero?
      first_n = params[:recorded_by].partition(' ').first
      last_n = params[:recorded_by].partition(' ').last
      users = User.where(first_name: first_n, last_name: last_n)
      @user = users[0]
    else
      @user = User.find(params[:vol_id])
    end
  end

  def set_student
    @student = Student.find(params[:student_id])
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_session
    @session = Session.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def session_params
    params.require(:session).permit(:student_id, :lesson_id, :lesson_identifier, :word_missed, :words_missed_one, :words_missed_two, :mood_one, :mood_two, :date, :time, :student_mood, :recorded_by, :vol_mood, :vol_id, :acumen, :first_attempt, :second_attempt, :num_words_learned, :comments)
  end
end
