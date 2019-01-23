class Swagger::DraRecord < Swagger::Model

  swagger_schema :dra_record do
    property :grade do
      key :type, :string
    end
    property :school_year do
      key :type, :string
    end
    property :fall_dra do
      key :type, :integer
      key :format, :int64
    end
    property :winter_dra do
      key :type, :integer
      key :format, :int64
    end
    property :spring_dra do
      key :type, :integer
      key :format, :int64
    end
    property :fall_rit do
      key :type, :integer
      key :format, :int64
    end
    property :winter_rit do
      key :type, :integer
      key :format, :int64
    end
    property :spring_rit do
      key :type, :integer
      key :format, :int64
    end
    property :fall_rank do
      key :type, :integer
      key :format, :int64
    end
    property :winter_rank do
      key :type, :integer
      key :format, :int64
    end
    property :spring_rank do
      key :type, :integer
      key :format, :int64
    end

    property :fall_lexile do
      key :type, :string
    end
    property :winter_lexile do
      key :type, :string
    end
    property :spring_lexile do
      key :type, :string
    end

    property :student_id do
      key :type, :integer
      key :format, :int64
    end
  end

end
