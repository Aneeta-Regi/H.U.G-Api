class Swagger::Resolution < Swagger::Model  
  swagger_schema :resolution do
    property :user_name do
      key :type, :string
    end
    property :comment do
      key :type, :string
    end
    property :feedback_id do
      key :type, :integer
      key :format, :int64
    end
  end
end
