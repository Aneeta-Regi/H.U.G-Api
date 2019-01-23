class Swagger::Student < Swagger::Model
  swagger_schema :student do    
    property :first_name do
      key :type, :string
    end
    property :s_last_name do
      key :type, :string
    end
    property :class_name do
      key :type, :string
    end
    property :grade do
      key :type, :string
    end
    property :notes do
      key :type, :string
    end
    property :why_inactive do
      key :type, :string
    end
    property :second_grade_year do
      key :type, :string
    end
    property :third_grade_year do
      key :type, :string
    end
    property :other_program_notes do
      key :type, :string
    end
    property :vol_name do
      key :type, :string
    end
    property :vol_email do
      key :type, :string
    end
    property :vol_phone do
      key :type, :string
    end

    property :active do
      key :type, :boolean
    end
    property :control_group do
      key :type, :boolean
    end

    property :num_other_programs do
      key :type, :integer
      key :format, :int64
    end

    property :user_id do
      key :type, :integer
      key :format, :int64
    end
    property :school_id do
      key :type, :integer
      key :format, :int64
    end
    property :vol_ids do
      key :type, :array
      items do
        key :type, :integer
        key :format, :int64
      end
    end
  end
end
