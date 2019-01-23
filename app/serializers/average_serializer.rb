class AverageSerializer < ActiveModel::Serializer
  attributes :id, :acumen_one, :acumen_two, :mood_one, :mood_two, :time_one, :time_two, :student_id
end
