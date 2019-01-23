class UserSerializerNew < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :email, :commitment_level, :phone,
             :second_phone, :persona, :background_check,
             :code_of_ethics, :completed_shadow_days, :e_first_name, :e_last_name, :emergency_contact_number,
             :image, :notes, :specialist, :teacher_exp, :counselor_exp, :active,
             :share_phone, :student_matching_level, :simple_students, :school_id

  def phone
    if object.share_phone
      object.phone
    end
  end

  def second_phone
    if object.share_phone
      object.second_phone
    end
  end

  def simple_students
    simple_students = []
    students = Student.where(user_id: object.id)

    students.each do |s|
      simple_students << {id: s.id, first_name: s.first_name, class_name: s.class_name, school_id: s.school_id}
    end
    return simple_students
  end

end


