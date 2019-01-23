class Swagger::ResolutionsController < Swagger::BaseController
  swagger_path '/resolutions' do
    operation :post do
      key :summary, 'Create new resolution'
      key :description, 'Resolution date is set by the db as the created_at date and returned stripped of time'
      key :consumes, ['application/json']
      key :produces, ['application/json']
      key :tags,['Resolutions']
      security Authorization: []
      parameter do
        key :name, :resolution
        key :in, :body
        key :description, "resolution json"
        key :required, true
        schema do
          key :'$ref',:resolution
        end
      end
    end
  end
end
