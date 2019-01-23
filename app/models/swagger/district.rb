class Swagger::District < Swagger::Model
  swagger_schema :district do
    property :name do
      key :type, :string
    end
    property :state do
      key :type, :string
    end
  end
end