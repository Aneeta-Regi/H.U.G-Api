class Swagger::LessonsController < Swagger::BaseController
  swagger_path '/lessons' do
    operation :post do
      key :summary, 'Create lesson'
      key :description, 'For testing purposes when creating a lesson please make sure the word count is anything other than 100 it affects the acumen'
      key :consumes, ['application/json']
      key :produces, ['application/json']
      key :tags,['Lessons']
      security Authorization: []
      parameter do
        key :name, :lesson
        key :in, :body
        key :description, "school json"
        key :required, true
        schema do
          key :'$ref',:lesson
        end
      end
    end
    operation :get do
      key :summary, 'List all lessons'
      key :description, 'List all lessons'
      key :produces, ['application/json']
      key :tags,['Lessons']
      security Authorization: []
    end
  end
  swagger_path '/lessons_no_image' do
    operation :get do
      key :summary, 'List all lessons excluding images'
      key :description, 'List all lessons excluding images'
      key :produces, ['application/json']
      key :tags,['Lessons']
      security Authorization: []
    end
  end
  swagger_path '/lessons/{lesson_id}' do
    parameter do
      key :name, :lesson_id
      key :in, :path
      key :description, "school id"
      key :required, true
    end
    operation :get do
      key :summary, 'Show lesson'
      key :description, 'Show lesson'
      key :produces, ['application/json']
      key :tags,['Lessons']
      security Authorization: []
    end
    operation :put do
      key :summary, 'Update lesson'
      key :description, 'Update lesson'
      key :consumes, ['application/json']
      key :produces, ['application/json']
      key :tags,['Lessons']
      parameter do
        key :name, :lesson
        key :in, :body
        key :description, "school json"
        key :required, true
        schema do
          key :'$ref',:lesson
        end
      end
    end
    operation :delete do
      key :summary, 'delete lesson'
      key :description, 'delete lesson'
      key :produces, ['application/json']
      key :tags,['Lessons']
      security Authorization: []
    end
  end
end
