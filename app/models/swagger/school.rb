class Swagger::School < Swagger::Model  
  swagger_schema :school do
    property :school_phone do
      key :type, :string
    end
    property :school_city do
      key :type, :string
    end
    property :school_state do
      key :type, :string
    end
    property :school_district do
      key :type, :string
    end
    property :principal_name do
      key :type, :string
    end
    property :vice_principal_name do
      key :type, :string
    end
    property :clarity_person_name do
      key :type, :string
    end
    property :clarity_person_phone do
      key :type, :string
    end
    property :clarity_person_second_phone do
      key :type, :string
    end
    property :clarity_person_email do
      key :type, :string
    end
    property :notes do
      key :type, :string
    end

    property :school_zip do
      key :type, :integer
      key :format, :int64
    end
    property :district_id do
      key :type, :integer
      key :format, :int64
    end

  end
end
