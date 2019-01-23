class AbsenceSerializer < ActiveModel::Serializer
  attributes :id, :student_id, :date, :vol_id, :recorded_by, :lesson_id, :lesson_name, :lesson_identifier
end
