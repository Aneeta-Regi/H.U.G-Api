class Swagger::Feedback < Swagger::Model
  swagger_schema :feedback do
    property :email do
      key :type, :string
    end
    property :mood do
      key :type, :integer
      key :format, :int64
    end
    property :comments do
      key :type, :string
    end
  end
end
