class Swagger::AuthenticationController < Swagger::BaseController

  swagger_path '/volunteer/login' do
    operation :post do
      key :summary, 'Login'
      key :description, 'New users that have been made by batch or have not completed their shadow days will be inactive. Also when a user is no longer working with the program they will be marked inactive.  If the account is inactive they will not be able to log in.'
      key :produces, ['application/json']
      key :tags,['Authentication']
      parameter do
        key :name, :email
        key :in, :formData
        key :description, "user email"
        key :type, :string
        key :required, true
      end
      parameter do
        key :name, :password
        key :in, :formData
        key :description, "user password"
        key :type, :string
        key :required, true
      end

    end
  end

end
