class Swagger::PasswordsController < Swagger::BaseController
  swagger_path '/updatepass' do
    operation :post do
      key :summary, 'Reset password'
      key :description, "For mobile teams the link to request a new password is 'https://hug-backend-dev.herokuapp.com/updatepass'.
      <br>An email will be sent with a link to reset your password that will contain a randomly generated password reset key"
      key :produces, ['application/json']
      key :tags,['Passwords']
      parameter do
        key :name, :email
        key :in, :formData
        key :description, "user email"
        key :required, true
        key :type, :string
      end
    end
  end

  swagger_path '/reset/{token}' do
    operation :put do
      key :summary, 'Set new password'
      key :description, "The token will be passed into the webpage when a user clicks the link from the update password instructions email. It will look like K9KzMzMuDrfEwjgw6BoD This key is generated dynamically when a new user is created or the reset password link is clicked. We only need the new password. There is no authentication because it is in the token. The token is reset to null after the password has been reset"
      key :produces, ['application/json']
      key :tags,['Passwords']
      parameter do
        key :name, :token
        key :in, :path
        key :description, "Password reset token"
        key :required, true
        key :type, :string
      end
      parameter do
        key :name, :password
        key :in, :formData
        key :description, "New password"
        key :required, true
        key :type, :string
      end
    end
  end
end
