class ResponseHelper

  # login
  BAD_TOKEN = 'Json Web Token is invalid. check your header.'

  #environmental variables that are used by classes
  # General error messages
  ERROR_NOT_FOUND = 'That record has not been found.'
  ERROR_USER_NOT_UNIQUE = 'That email is already in our system. Please check your information.'
  ERROR_INVALID_LOGIN = 'Invalid email or password.'
  ERROR_REQUIREMENTS_NOT = 'You are currently unable to login until Admin or Specialist marks you active.'
  ERROR_NOT_SPECIAL = 'Only specialist are able to edit this type of record. Please see program management.'
  ERROR_NOT_ADMIN = 'Permisson denied. Only HUG Administrators may access the web portal.'

  #sessions

  THIRD_SESSION_ERROR = 'A second attempt has already been logged for this lesson.'

  # mailer info

  PASSWORD_RESET_URL = 'http://app.hugreadingprogram.org/'

  WELCOME_SUBJECT_LINE = 'Welcome to HUG!'

  DEFAULT_FROM_ADDRESS = 'hugdemotesting@gmail.com'

  RESET_PASSWORD_LINE = ' HUG Password reset request.'

  PASSWORD_RESET_SUCCESS = 'Password reset successfully.'

  FEEDBACK_SUBJECT = 'HUG Feedback has been received.'

  S3_URL_BASE = 'https://s3.us-east-2.amazonaws.com/hug-api/images/'


end