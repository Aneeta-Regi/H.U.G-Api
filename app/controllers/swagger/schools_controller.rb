class Swagger::SchoolsController < Swagger::BaseController

  swagger_path '/schools' do
    operation :post do
      key :summary, 'Create school'
      key :description, 'Create new school'
      key :consumes, ['application/json']
      key :produces, ['application/json']
      key :tags,['Schools']
      security Authorization: []
      parameter do
        key :name, :school
        key :in, :body
        key :description, "school json"
        key :required, true
        schema do
          key :'$ref',:school
        end
      end
    end
    operation :get do
      key :summary, 'List all schools'
      key :description, 'This method returns a list of all schools with students'
      key :produces, ['application/json']
      key :tags,['Schools']
      security Authorization: []
    end
  end
  swagger_path '/schools_no_students' do
    operation :get do
      key :summary, 'List all schools excluding students'
      key :description, 'This method returns a list of all schools withouts its students'
      key :produces, ['application/json']
      key :tags,['Schools']
      security Authorization: []
    end
  end
  swagger_path '/schools/{school_id}' do
    parameter do
      key :name, :school_id
      key :in, :path
      key :description, "school id"
      key :required, true
    end
    operation :get do
      key :summary, 'Show school'
      key :description, 'Will show school and its students'
      key :produces, ['application/json']
      key :tags,['Schools']
      security Authorization: []
    end
    operation :put do
      key :summary, 'Update school'
      key :description, 'Not all information is required to be sent. If you only need to sent just the updated info that is no problem'
      key :consumes, ['application/json']
      key :produces, ['application/json']
      key :tags,['Schools']
      parameter do
        key :name, :school
        key :in, :body
        key :description, "school json"
        key :required, true
        schema do
          key :'$ref',:school
        end
      end
    end
    operation :delete do
      key :summary, 'delete school'
      key :description, 'delete school'
      key :produces, ['application/json']
      key :tags,['Schools']
      security Authorization: []
    end
  end
end
