
class Swagger::Lesson < Swagger::Model
  swagger_schema :lesson do
    property :lesson_name do
      key :type, :string
    end
    property :summary do
      key :type, :string
    end
    property :lesson_identifier do
      key :type, :string
    end
    property :image do
      key :type, :string
    end
    property :sec_image do
      key :type, :string
    end

    property :total_word do
      key :type, :integer
      key :format, :int64
    end
    property :grade_level do
      key :type, :integer
      key :format, :int64
    end
  end

end
