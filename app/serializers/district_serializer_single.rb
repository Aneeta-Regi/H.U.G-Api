class DistrictSerializerSingle < ActiveModel::Serializer
  has_many :schools
  attributes :id, :name, :state, :num_schools
end


def num_schools
  schools = School.where(district_id: self.id)
  num_schools = schools.size
  num_schools
end