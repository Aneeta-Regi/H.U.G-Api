class LessonSerializer < ActiveModel::Serializer

  attributes :id, :lesson_name, :summary, :total_word, :grade_level, :lesson_identifier, :image, :sec_image
end


