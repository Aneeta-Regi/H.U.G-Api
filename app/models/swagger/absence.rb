class Swagger::Absence < Swagger::Model
  swagger_schema :absence do
    property :lesson_name do
      key :type, :string
    end

    property :lesson_identifier do
      key :type, :string
    end
    property :recorded_by do
      key :type, :string
    end

    property :date do
      key :type, :string
      key :format, :"date-time"
    end

    property :lesson_id do
      key :type, :integer
      key :format, :int64
    end
    property :student_id do
      key :type, :integer
      key :format, :int64
    end

    property :vol_id do
      key :type, :integer
      key :format, :int64
    end
  end
end
