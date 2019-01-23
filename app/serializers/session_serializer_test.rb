class SessionSerializerTest < ActiveModel::Serializer

  attributes :session

  def session
    if object.second_attempt
      sessions_com = {}
    else
      lesson = Lesson.find_by(id: object.lesson_id)
      lesson_title = lesson.nil? ? 'lesson was deleted' : lesson.lesson_name
      lesson_identifier = lesson.nil? ? '0' : lesson.lesson_identifier
      lesson_grade = lesson.nil? ? 'lesson was deleted' : lesson.grade_level
      session_two = Session.where(lesson_id: object.lesson_id, student_id: object.student_id, second_attempt: true)
      session_two_id = session_two.empty? ? nil : session_two[0].id
      acumen_two = session_two.empty? ? nil : session_two[0].acumen
      mood_two = session_two.empty? ? nil : session_two[0].student_mood
      words_missed_two = session_two.empty? ? nil : session_two[0].word_missed
      num_words_learned = session_two.empty? ? nil : session_two[0].num_words_learned
      comments = session_two.empty? ? nil : session_two[0].comments

      if session_two.empty?
        vol_mood = nil
      else
        feedback = Feedback.where(session_id: session_two_id)
        vol_mood = feedback.empty? ? nil : feedback[0].mood
      end
      vol_id = vol_inf

      sessions_com = { student_id: object.student_id, lesson_title: lesson_title,
                       lesson_identifier: lesson_identifier, lesson_grade: lesson_grade,
                       lesson_total_word_count: lesson.total_word,
                       date: object.date, recorded_by: object.recorded_by,
                       session_one_id: object.id, acumen_one: object.acumen,
                       mood_one: object.student_mood, words_missed_one: object.word_missed,
                       session_two_id: session_two_id, acumen_two: acumen_two,
                       mood_two: mood_two, words_missed_two: words_missed_two,
                       num_words_learned: num_words_learned, comments: comments,
                       vol_id: vol_id, vol_mood: vol_mood }
    end
    sessions_com
  end

  def vol_inf
    if object.recorded_by.nil?
      vol_id = nil
    else
      f_name = object.recorded_by.partition(' ').first
      l_name = object.recorded_by.partition(' ').last
      vol = User.where(first_name: f_name, last_name: l_name)
      vol_id = vol.empty? ? nil : vol[0].id
    end
    vol_id
  end

end