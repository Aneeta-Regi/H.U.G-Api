class Swagger::UsersController < Swagger::BaseController
  swagger_path '/new/volunteer' do
    operation :post do
      key :summary, 'Create volunteer'
      key :description, 'Email must be unique. Share_phone defaults to true, you must set it to false if keeping phone numbers private '
      key :consumes, ['application/json']
      key :produces, ['application/json']
      key :tags,['Users Volunteers']
      parameter do
        key :name, :user
        key :in, :body
        key :description, "user json"
        key :required, true
        schema do
          key :'$ref',:user
        end
      end
    end
  end

  swagger_path '/all/volunteers' do
    operation :get do
      key :summary, 'List all volunteers'
      key :description, 'Returns an array of information for all users and the students they are associated with'
      key :produces, ['application/json']
      key :tags,['Users Volunteers']
      security Authorization: []
    end
  end
  swagger_path '/all/volunteers/simple' do
    operation :get do
      key :summary, 'List simple volunteers'
      key :description, 'Returns an array of information for all users and the students they are associated with'
      key :produces, ['application/json']
      key :tags,['Users Volunteers']
      security Authorization: []
    end
  end
  swagger_path '/all/volunteers/web' do
    operation :get do
      key :summary, 'List web volunteers'
      key :description, 'Returns an array of information for all users and the students they are associated with'
      key :produces, ['application/json']
      key :tags,['Users Volunteers']
      security Authorization: []
    end
  end
  swagger_path '/inactive/volunteers' do
    operation :get do
      key :summary, 'List inactive volunteers'
      key :description, 'List inactive users'
      key :produces, ['application/json']
      key :tags,['Users Volunteers']
      security Authorization: []
    end
  end
  swagger_path '/volunteer/{user_id}' do
    parameter do
      key :name, :user_id
      key :in, :path
      key :description, "user id"
      key :required, true
    end
    operation :get do
      key :summary, 'Show user'
      key :description, 'Returns the user information. The user id is encoded in the auth token and the rails server decodes and assigns the Current User'
      key :produces, ['application/json']
      key :tags,['Users Volunteers']
      security Authorization: []
    end
  end
  swagger_path '/self' do
    operation :get do
      key :summary, 'Show current user'
      key :description, 'Returns the user information. The user id is encoded in the auth token and the rails server decodes and assigns the Current User'
      key :produces, ['application/json']
      key :tags,['Users Volunteers']
      security Authorization: []
    end
  end
  swagger_path '/update/volunteer/{user_id}' do
    parameter do
      key :name, :user_id
      key :in, :path
      key :description, "user id"
      key :required, true
    end
    operation :put do
      key :summary, 'Update user'
      key :description, 'Update user'
      key :consumes, ['application/json']
      key :produces, ['application/json']
      key :tags,['Users Volunteers']
      security Authorization: []
      parameter do
        key :name, :user
        key :in, :body
        key :description, "user json"
        key :required, true
        schema do
          key :'$ref',:user
        end
      end
    end
  end
  swagger_path '/volunteer/set_activity/{user_id}' do
    parameter do
      key :name, :user_id
      key :in, :path
      key :description, "user id"
      key :required, true
    end
    operation :put do
      key :summary, "Toggle user's active status"
      key :description, "Toggle user's active status. <br>You can also set the user to active or inactive another way.  When updating the user you can just include the active attribute and set it to whatever you want"
      key :produces, ['application/json']
      key :tags,['Users Volunteers']
      security Authorization: []
    end
  end

end
