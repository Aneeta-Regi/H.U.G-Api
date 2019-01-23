class Swagger::AbsencesController < Swagger::BaseController
  swagger_path '/absences' do
    operation :post do
      key :summary, 'Create new absence'
      key :description, 'Create new absence'
      key :consumes, ['application/json']
      key :produces, ['application/json']
      key :tags,['Absences']
      security Authorization: []
      parameter do
        key :name, :absence
        key :in, :body
        key :description, "Absence json"
        key :required, true
        schema do
          key :'$ref',:absence
        end
      end
    end
    operation :get do
      key :summary, 'List all absences'
      key :description, 'This returns an array of absences.  But you will not use this'
      key :produces, ['application/json']
      key :tags,['Absences']
      security Authorization: []
    end
  end

  swagger_path '/absences/{id}' do
    parameter do
      key :name, :id
      key :in, :path
      key :description, "school id"
      key :required, true
    end
    operation :put do
      key :summary, 'Update absense'
      key :description, 'Update absense'
      key :consumes, ['application/json']
      key :produces, ['application/json']
      key :tags,['Absences']
      parameter do
        key :name, :absence
        key :in, :body
        key :description, "Absence json"
        key :required, true
        schema do
          key :'$ref',:absence
        end
      end
    end
    operation :delete do
      key :summary, 'delete absense'
      key :description, 'delete absence'
      key :produces, ['application/json']
      key :tags,['Absences']
      security Authorization: []
    end
  end

end
