class StudentSerializerSession < ActiveModel::Serializer
  attributes :id, :undone_lesson_list, :vol_name_list

  def undone_lesson_list
    lessons = Lesson.where(active: true).order(:grade_level, :lesson_identifier)
    # establish the array to be rendered
    undone_lesson_list = []
    lessons.each do |lesson|
      if lesson.grade_level.to_s == object.grade[0, 1]
      unless Session.where(student_id: object.id, lesson_id: lesson.id, second_attempt: true).exists?
        undone_lesson_list << { lesson_name: lesson.lesson_name,
                                total_word: lesson.total_word, grade_level: lesson.grade_level,
                                lesson_identifier: lesson.lesson_identifier,
                                lesson_id: lesson.id }
      end
        end
    end
    undone_lesson_list
  end

  def vol_name_list
    argument = object.school_id.to_s + ' = ANY (school_id)'
    vols = User.where(argument)
    vol_name_list = []
    vols.each do |vol|
      if vol.active
        vol_name_list << { vol_name: vol.first_name + ' ' + vol.last_name, vol_id: vol.id }
      end
    end
    vol_name_list
  end

end