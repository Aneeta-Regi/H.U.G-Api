class Swagger::AppLink < Swagger::Model  
  swagger_schema :app_link do
    property :title do
      key :type, :string
    end
    property :description do
      key :type, :string
    end
    property :link do
      key :type, :string
    end
    property :icon do
      key :type, :string
    end
    property :sort_order do
      key :type, :integer
      key :format, :int64
    end
  end
end
