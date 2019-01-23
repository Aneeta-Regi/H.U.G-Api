class Swagger::SessionsController < Swagger::BaseController
  swagger_path '/sessions' do
    operation :post do
      key :summary, 'Create session'
      key :description, 'Sessions belong to a student. User_id is the person who recorded the information in the session. The first and second attempts are'
      key :consumes, ['application/json']
      key :produces, ['application/json']
      key :tags,['Sessions']
      security Authorization: []
      parameter do
        key :name, :session
        key :in, :body
        key :description, "Session json"
        key :required, true
        schema do
          key :'$ref',:session
        end
      end
    end
    operation :get do
      key :summary, 'List all Sessions'
      key :description, 'List all Sessions'
      key :produces, ['application/json']
      key :tags,['Sessions']
      security Authorization: []
    end
  end
  swagger_path '/sessions/new' do
    operation :post do
      key :summary, 'Create new session'
      key :description, 'Sessions belong to a student. User_id is the person who recorded the information in the session. The first and second attempts are generated automatically by the backend. Users could create a third session but saving will result in a 422 error.'
      key :consumes, ['application/json']
      key :produces, ['application/json']
      key :tags,['Sessions']
      security Authorization: []
      parameter do
        key :name, :session
        key :in, :body
        key :description, "Session json"
        key :required, true
        schema do
          key :'$ref',:session
        end
      end
    end
  end
  swagger_path '/student/setup/{id}' do
    operation :get do
      key :summary, 'Setup Sessions'
      key :description, 'We send nothing but remember we base the list off the id in the call.
      <br>The returned id is the student’s id.
      <br>These undone lessons list is the same as before.
      <br>The vol_name_list is all available volunteers at the same school as the student you are creating a session for.'
      key :produces, ['application/json']
      key :tags,['Sessions']
      security Authorization: []
    end
  end
  swagger_path '/com_sessions/{id}' do
    operation :get do
      key :summary, 'Combine sessions'
      key :description, 'This is to make populating the update sessions screen easier.  It contains all the info for both sessions the lesson and the feedback if available'
      key :produces, ['application/json']
      key :tags,['Sessions']
      security Authorization: []
    end
  end
  swagger_path '/sessions/{session_id}' do
    parameter do
      key :name, :session_id
      key :in, :path
      key :description, "school id"
      key :required, true
    end
    operation :put do
      key :summary, 'Update school'
      key :description, 'Sessions belong to a student. User_id is the person who recorded the information in the session. The first and second attempts are generated automatically by the backend. Users could create a third session but saving will result in a 422 error'
      key :consumes, ['application/json']
      key :produces, ['application/json']
      key :tags,['Sessions']
      parameter do
        key :name, :session
        key :in, :body
        key :description, "school json"
        key :required, true
        schema do
          key :'$ref',:session
        end
      end
    end
    operation :delete do
      key :summary, 'delete session'
      key :description, 'delete session'
      key :produces, ['application/json']
      key :tags,['Sessions']
      security Authorization: []
    end
  end
end
