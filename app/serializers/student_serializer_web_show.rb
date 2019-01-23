class StudentSerializerWebShow < ActiveModel::Serializer

  has_many :sessions
  has_one :average
  has_many :dra_records
  has_many :absences

  attributes :id, :first_name, :s_last_name, :class_name, :school_id, :school_name, :school_phone,
             :user_id, :zip_code, :clarity_email, :clarity_person_name, :clarity_phone,
             :clarity_alt_phone, :updated_at, :second_grade_year, :third_grade_year, :fifth_grade_year,
             :other_program_notes, :num_other_programs, :notes, :active, :why_inactive,
             :control_group, :grade, :vol_name, :vol_email, :vol_phone, :vol_ids, :vol_list, :scores

  def vol_list
    vol_list = []
    object.vol_ids.each do |v|
      vol = User.find(v)
      vol_list << { vol_name: vol.first_name + ' ' + vol.last_name, vol_email: vol.email, vol_id: vol.id }
    end
    vol_list
  end

  def school_phone
    school = School.find(object.school_id)
    school_phone = school.school_phone
    school_phone
  end

  def scores
    scores = []
    object.dra_records.each do |r|
      scores << { id: r.id, grade: r.grade, school_year: r.school_year, student_id: r.student_id,
                  dra: { fall: r.fall_dra, winter: r.winter_dra, spring: r.spring_dra },
                  rit: { fall: r.fall_rit, winter: r.winter_rit, spring: r.spring_rit },
                  rank: { fall: r.fall_rank, winter: r.winter_rank, spring: r.spring_rank },
                  lexile: { fall_one: r.fall_lexile_one, fall_two: r.fall_lexile_two,
                            winter_one: r.winter_lexile_one, winter_two: r.winter_lexile_two,
                            spring_one: r.spring_lexile_one, spring_two: r.spring_lexile_two } }
    end
    scores
  end

end
