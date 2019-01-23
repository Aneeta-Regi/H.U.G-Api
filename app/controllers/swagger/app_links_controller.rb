class Swagger::AppLinksController < Swagger::BaseController
  swagger_path '/app_links' do
    operation :post do
      key :summary, 'Create new Applink'
      key :description, 'Create new Applink'
      key :consumes, ['application/json']
      key :produces, ['application/json']
      key :tags,['AppLinks']
      security Authorization: []
      parameter do
        key :name, :app_link
        key :in, :body
        key :description, "AppLink json"
        key :required, true
        schema do
          key :'$ref',:app_link
        end
      end
    end
    operation :get do
      key :summary, 'List all Applinks'
      key :description, 'List all Applinks'
      key :produces, ['application/json']
      key :tags,['AppLinks']
      security Authorization: []
    end
  end

  swagger_path '/app_links/{id}' do
    parameter do
      key :name, :id
      key :in, :path
      key :description, "AppLink id"
      key :required, true
    end
    operation :get do
      key :summary, 'Show AppLink'
      key :description, 'Show AppLink'
      key :produces, ['application/json']
      key :tags,['AppLinks']
      security Authorization: []
    end
    operation :put do
      key :summary, 'Update AppLink'
      key :description, 'Update AppLink'
      key :consumes, ['application/json']
      key :produces, ['application/json']
      key :tags,['AppLinks']
      parameter do
        key :name, :app_link
        key :in, :body
        key :description, "AppLink json"
        key :required, true
        schema do
          key :'$ref',:app_link
        end
      end
    end
    operation :delete do
      key :summary, 'delete AppLink'
      key :description, 'delete AppLink'
      key :produces, ['application/json']
      key :tags,['AppLinks']
      security Authorization: []
    end
  end
end
