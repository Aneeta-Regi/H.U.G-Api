class UserSerializer < ActiveModel::Serializer
  has_many :students
  has_many :schools
  attributes :id, :first_name, :last_name, :email, :commitment_level, :phone, :second_phone, :persona, :background_check,
             :code_of_ethics, :completed_shadow_days, :e_first_name, :e_last_name, :emergency_contact_number,
             :image, :notes, :specialist, :teacher_exp, :counselor_exp, :student_matching_level, :active, :share_phone, :school_id

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


end
