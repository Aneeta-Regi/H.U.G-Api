class Swagger::DistrictsController < Swagger::BaseController

  swagger_path '/districts' do
    operation :post do
      key :summary, 'Create District'
      key :description, 'Create a district to make it available in the create school options.'
      key :consumes, ['application/json']
      key :produces, ['application/json']
      key :tags,['Districts']
      security Authorization: []
      parameter do
        key :name, :district
        key :in, :body
        key :description, "District json"
        key :required, true
        schema do
          key :'$ref',:district
        end
      end
    end
    operation :get do
      key :summary, 'List all Districts'
      key :description, 'List all Districts'
      key :produces, ['application/json']
      key :tags,['Districts']
      security Authorization: []
    end
  end

  swagger_path '/districts/{id}' do
    operation :put do
      key :summary, 'Update District'
      key :description, 'Update District'
      key :consumes, ['application/json']
      key :produces, ['application/json']
      key :tags,['Districts']
      security Authorization: []
      parameter do
        key :name, :id
        key :in, :path
        key :required, true
      end
      parameter do
        key :name, :district
        key :in, :body
        key :description, "District json"
        key :required, true
        schema do
          key :'$ref',:district
        end
      end
    end

    operation :delete do
      key :summary, 'Delete District'
      key :description, 'Delete District'
      key :consumes, ['application/json']
      key :produces, ['application/json']
      key :tags,['Districts']
      security Authorization: []
      parameter do
        key :name, :id
        key :in, :path
        key :required, true
      end
    end

  end


end
