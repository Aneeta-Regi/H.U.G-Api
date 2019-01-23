class UserSerializerWebIndex < ActiveModel::Serializer

  attributes :id, :first_name, :last_name, :email, :commitment_level,
             :phone, :specialist, :teacher_exp, :background_check, :code_of_ethics,
             :completed_shadow_days, :counselor_exp, :student_matching_level,
             :active, :share_phone, :school_id, :schools

  def phone
    if object.share_phone
      object.phone
    end
  end

  def schools
    schools = []
    object.school_id.each do |s|
      if School.where(id: s).exists?
        school = School.find(s)
        schools << { school_name: school.school_name }
      end
    end
    schools
  end


end
