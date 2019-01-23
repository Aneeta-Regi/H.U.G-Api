class SessionSerializer < ActiveModel::Serializer
  has_many :feedbacks
  attributes :id, :student_id, :student_name, :date, :lesson_id, :word_missed, :time, :student_mood, :recorded_by,
             :acumen, :first_attempt, :second_attempt, :lesson_identifier, :grade_level, :school_year, :school_id, :school_name,
             :num_words_learned, :comments, :vol_mood, :vol_id, :lesson_info

# define the lesson info setup an array then based off the lesson id in the sesson set the lesson then grab the name id and grade level
# check if the lesson is nil as this means that the lesson was deleted.
  def lesson_info

    lesson_info = []
    lesson = Lesson.find_by(id: object.lesson_id)

    if lesson.nil?
      lesson_info << { lesson_title: 'lesson was deleted', lesson_identifier: '0', lesson_grade: 'lesson was deleted' }
    else
      lesson_info << { lesson_title: lesson.lesson_name, lesson_identifier: lesson.lesson_identifier, lesson_grade: lesson.grade_level }
    end

    lesson_info
  end

  def vol_mood
    if object.second_attempt
      feedback = Feedback.where(session_id: object.id)
      vol_mood = feedback.empty? ? nil : feedback[0].mood
    end
    vol_mood
  end

  def vol_id
    if object.second_attempt
      feedback = Feedback.where(session_id: object.id)
      vol_id = feedback.empty? ? nil : feedback[0].vol_id
    end
    vol_id
  end

end