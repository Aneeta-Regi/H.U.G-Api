class Swagger::DraRecordsController < Swagger::BaseController
  swagger_path '/dra_records' do
    operation :post do
      key :summary, 'Create dra record'
      key :description, 'dra scores and student id are integers all others are strings'
      key :consumes, ['application/json']
      key :produces, ['application/json']
      key :tags,['DRA Records']
      security Authorization: []
      parameter do
        key :name, :dra_record
        key :in, :body
        key :description, "dra record json"
        key :required, true
        schema do
          key :'$ref',:dra_record
        end
      end
    end
  end

  swagger_path '/dra_records/{dra_record_id}' do
    parameter do
      key :name, :dra_record_id
      key :in, :path
      key :description, "dra_record id"
      key :required, true
    end
    operation :put do
      key :summary, 'Update dra record'
      key :description, 'Dra scores and student id are integers all others are strings.'
      key :consumes, ['application/json']
      key :produces, ['application/json']
      key :tags,['DRA Records']
      parameter do
        key :name, :dra_record
        key :in, :body
        key :description, "school json"
        key :required, true
        schema do
          key :'$ref',:dra_record_id
        end
      end
    end
  end

end
