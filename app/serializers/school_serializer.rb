class SchoolSerializer < ActiveModel::Serializer
  has_many :students
  has_many :users
  # belongs_to :district, except: [:school_list]

  def volunteer_id
    object.volunteer.ids
  end

  def students_id
    object.student.ids
  end

  attributes :id, :school_name, :school_phone, :address, :school_city,
             :school_state, :school_zip, :district_id, :principal_name,
             :vice_principal_name, :clarity_person_name, :clarity_person_phone,
             :clarity_person_second_phone, :clarity_person_email, :notes, :district


  def district
    dis = District.find(object.district_id)
    district = { id: dis.id, name: dis.name, state: dis.state }
  end

end
