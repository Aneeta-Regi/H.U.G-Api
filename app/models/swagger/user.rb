class Swagger::User < Swagger::Model
  swagger_schema :user do
    key :required, [:first_name,:last_name,:email]
    property :first_name do
      key :type, :string
    end
    property :last_name do
      key :type, :string
    end
    property :email do
      key :type, :string
    end
    property :commitment_level do
      key :type, :string
    end
    property :phone do
      key :type, :string
    end
    property :second_phone do
      key :type, :string
    end
    property :second_phone do
      key :type, :string
    end
    property :persona do
      key :type, :string
    end
    property :e_first_name do
      key :type, :string
    end
    property :e_last_name do
      key :type, :string
    end
    property :emergency_contact_number do
      key :type, :string
    end
    property :image do
      key :type, :string
    end
    property :notes do
      key :type, :string
    end

    property :background_check do
      key :type, :boolean
    end
    property :code_of_ethics do
      key :type, :boolean
    end
    property :completed_shadow_days do
      key :type, :boolean
    end
    property :specialist do
      key :type, :boolean
    end
    property :teacher_exp do
      key :type, :boolean
    end
    property :counselor_exp do
      key :type, :boolean
    end
    property :active do
      key :type, :boolean
    end
    property :share_phone do
      key :type, :boolean
    end
    property :school_id do
      key :type, :array
      items do
        key :type, :integer
        key :format, :int64
      end

    end

  end
end
