class Swagger::StudentsController < Swagger::BaseController
  swagger_path '/students' do
    operation :post do
      key :summary, 'Create student'
      key :description, 'When you send the user email and the school name the backend looks up those records and inserts the ID for each into the student model.  This is the association so you can pull a school and see all the students'
      key :consumes, ['application/json']
      key :produces, ['application/json']
      key :tags,['Students']
      security Authorization: []
      parameter do
        key :name, :student
        key :in, :body
        key :description, "Student json"
        key :required, true
        schema do
          key :'$ref',:student
        end
      end
    end
    operation :get do
      key :summary, 'List all students'
      key :description, 'List all students'
      key :produces, ['application/json']
      key :tags,['Students']
      security Authorization: []
    end
  end
  swagger_path '/students/{student_id}' do
    parameter do
      key :name, :student_id
      key :in, :path
      key :description, "sorting key"
      key :required, true
    end
    operation :get do
      key :summary, 'Show student'
      key :description, 'Show student'
      key :produces, ['application/json']
      key :tags,['Students']
      security Authorization: []
    end
    operation :put do
      key :summary, 'Update student'
      key :description, 'Not all information is required to be sent.
                        If you only need to sent just the updated info that is no problem.'
      key :consumes, ['application/json']
      key :produces, ['application/json']
      key :tags,['Students']
      security Authorization: []
      parameter do
        key :name, :student
        key :in, :body
        key :description, "student json"
        key :required, true
        schema do
          key :'$ref',:student
        end
      end
    end
  end
  swagger_path '/list_students_web' do
    operation :get do
      key :summary, 'List all web students'
      key :description, 'custom endpoint for web'
      key :produces, ['application/json']
      key :tags,['Students']
      security Authorization: []
    end
  end
  swagger_path '/list_students_web/{sort_by}' do
    parameter do
      key :name, :sort_by
      key :in, :path
      key :description, "sorting key"
      key :required, true
    end
    operation :get do
      key :summary, 'List all students sort by key'
      key :description, 'List all students sort by key'
      key :produces, ['application/json']
      key :tags,['Students']
      security Authorization: []
    end
  end
  swagger_path '/inactive/students' do
    operation :get do
      key :summary, 'List all inactive students'
      key :description, 'List all inactive students'
      key :produces, ['application/json']
      key :tags,['Students']
      security Authorization: []
    end
  end
  swagger_path '/deactivate/student/{student_id}' do
    parameter do
      key :name, :student_id
      key :in, :path
      key :description, "student id"
      key :required, true
    end
    operation :put do
      key :summary, 'Deactivate student'
      key :description, 'The student model has a flag named active which is default to true. This endpoint will set the active flag to false. The index or list all students endpoint will return a list of all active students. Additional options for why inactive: Graduated, Scored Out,  Moved, Removed, Control Group'
      key :produces, ['application/json']
      key :tags,['Students']
      security Authorization: []
    end
  end
  swagger_path '/reactivate/student/{id}' do
    parameter do
      key :name, :id
      key :in, :path
      key :description, "student id"
      key :required, true
    end
    operation :put do
      key :summary, 'Reactivate student'
      key :description, 'Reactivate student'
      key :produces, ['application/json']
      key :tags,['Students']
      security Authorization: []
    end
  end
end
