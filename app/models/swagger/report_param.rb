class Swagger::ReportParam < Swagger::Model
  swagger_schema :report_param do
    property :download do
      key :type, :boolean
      key :default, false
    end
    property :school_year do
      key :type, :string
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
