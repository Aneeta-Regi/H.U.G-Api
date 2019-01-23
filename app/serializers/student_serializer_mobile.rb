class StudentIndexMobile < ActiveModel::Serializer
  has_many :sessions
  has_one :average
  has_many :absences

  attributes :id, :first_name, :class_name, :school_id, :school_name, :user_id,
             :zip_code, :clarity_email, :clarity_person_name, :clarity_phone,
             :clarity_alt_phone, :updated_at, :notes, :second_grade_year, :third_grade_year,
             :fifth_grade_year, :other_program_notes, :control_group, :num_other_programs,
             :active, :grade, :vol_name, :vol_email, :vol_phone, :vol_ids, :vol_list

  def vol_list
    vol_list = []
    object.vol_ids.each do |v|
      vol = User.find(v)
      vol_list << {vol_name: vol.first_name + ' ' + vol.last_name, vol_email: vol.email, vol_id: vol.id }
    end
    return vol_list
  end


end

