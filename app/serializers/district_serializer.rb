class DistrictSerializer < ActiveModel::Serializer
  attributes :id, :name, :state, :school_list, :school_years
end

def school_list
  school_array = School.where(district_id: self.id)
  schools = []

  school_array.each do |s|
    tutors = []
    p s.users
    s.users.each do |t|
      tutors << { name: t.first_name + ' ' + t.last_name, id: t.id }
    end
    schools << { name: s.school_name, id: s.id, tutors: tutors }
  end
  schools
end

def school_years
  years = DraRecord.all.map(&:school_year)
  school_years = years.flatten.uniq
  school_years
end
#
# def tutor_list
#   tutor_list = @all_tutors
#   tutor_list
# end