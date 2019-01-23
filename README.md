# README

## HUG Backend ##

#### Main Contributors ####
Alex Hughes

### Installation Instructions *01.23.18* ###

Before starting install the dependencies and frameworks listed below. 
1. Clone the repo. 
2. In terminal navigate to the folder and run `bundle install` 
3. Download the database and secrets yml files from:
 https://drive.google.com/drive/u/0/folders/1ve551ylXywC40DwABHANAAX2TAKUShL7   copy them to the config folder of the project.
 
4. In terminal run `rake db:setup` 
   this will setup the Postgres database, and install all the tables. 
5. In terminal run `bin/rails server` to start the server. 
6. Navigate to http://localhost:3000 
7. Use postman to create a new user and add other data to your local database.

Backend docs are here: https://docs.google.com/document/d/1VjIrsQv6ALBoCMMKAvX7h8M4Savyc_cH3T43BChykOU/

### Tasks ###

These files are in the project folder: hug-backend/app/lib/tasks/scheduler.rake

`rake check_new_users`
runs once a day and checks for new tutors in the mail chimp schools lists and adds them to the application as inactive users. \
`rake add_sg_mc`
Runs daily to check for new users in sign up genius and add their information to MailChimp mailing list. 

----------

### Project Configuration #
`application.yml`
When deploying to AWS or other non-managed server an application.yml file will be required to set the environmental variables. 
Check the Heroku section for the required variables. 

`secrets.yml` 
Contains secret_key_base for accessing the api  

`database.yml` 
Contains information about the setup of the database and is used to create a secure connection to the database after deployment
 
### Heroku ###
In settings under config variables set the following:

Databse_url \
Gmail _password \
Gmail_user \
Lang \
Mailchimp_api_key \
Region \
S3_access_key_id \
S3_secret_access_key \
Secret_key_base \
Sg_user_key 

Connect Heroku project with a postgres DB to github repo. 
Under deploy in Heroku admin panel select GitHub and follow the instructions to connect your repo.
Enable auto deploy of chosen branch.

Under the more tab a the top right select Run Console and run the following commands. 

Bundle install  
this command checks the apps GEM file and installs the necessary dependencies and updates them. 

rake db:setup \
this initializes the database and runs the migrations to create the tables in the database. 

If deploying to AWS set the above in the project YML files and upload them manually to the server. 

#### Environments ####
##### Dev #####
Current server management is performed on the HEROKU admin panel located here:
https://dashboard.heroku.com/apps/hug-backend-dev \
Direct Link backend api:
https://hug-backend-dev.herokuapp.com/

##### Prod #####
Current server management is performed on the HEROKU admin panel located here:
https://dashboard.heroku.com/apps/hug-backend \
Direct Link backend API:
https://hug-backend.herokuapp.com/

#### Dependencies ####
You will need to download and install the following programs. Follow the instructions at the links provided. 

PostgreSQL 9.6 application. This creates a postgreSQL database server on your local machine. Be sure to set this to run at startup or you will have issues reconnecting to your database.  
 download here:   http://postgresapp.com/documentation/ 

RVM - Ruby version manager: 
https://rvm.io/

The following GEMs are required for this project, they are auto installed when you run the bundle install command and no further action should be required. If a specific version is required then that version number is included. Such as '1.1.0' at the end of the gem name. If no specific version is required the latest version available will be installed. 

'rack-cors' \
This is for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible for our web developers.  

'active_model_serializers' \
This is for managing custom responses of model attributes. 

'devise' \
'jwt' \
These are used for authentication and the creation of json web tokens that are encoded to allow for calls to be processed and checked for user access permissions without needing the users name and password each time.

'aws-sdk', '~> 2'  \
Connects the API to Amazon Web Services to allow access for S3 bucket uploads. 

'gibbon'
'rest-client' \
Used to connect to MailChimp for importing user information and passing through the sign up genius users. 

'rubyzip', '~> 1.1.0' \
'axlsx', '2.1.0.pre' \
'axlsx_rails' \
Used to create and export the excel sheet for the reporting feature. Rubyzip handles the the final wrapping of the file into excel format. While axlsx gems deal with creation and formatting of the workbooks.

#### Frameworks ####
rails 5.0.1 \
ruby version 2.3.1 \
You will need to use Ruby Version Manager to install these. RVM and instruction for installing rails and ruby can be found here: https://rvm.io/

#### Authentication ####
User authentication is handled by Devise and jwt. \
Reset password instructions and emails is controlled by devise. 
Authentication is based on Json Web Tokens. a secret key is used to encode the users email address and password in a base 64 token. This token is returned to the user at login. All requests must include this token in the header. Th JWT gem uses the secret key to decode the token and find th users information.

#### Hosting ####
Heroku is currently serving this API

#### Build Pipeline Configuration ####

Connecting the Heroku application to the Github repo will handle the build pipeline for you. Merge new code into the connected branch and Heroku will auto deploy the updated code.  \
Under Deploy in Heroku admin panel select GitHub as the deployment method. Follow the instructions to connect your repo. Just below that you will be able to enter which branch you wish to auto deploy by entering the name.

## Release Notes ##

----------

### Troubleshooting/Common Issues ###
**Can not run development server no Rails in SDK** \
your default versions of rails or ruby are set to a different version than the project requires. Check the required version of rails and ruby in the project's GEM file. In Ruby mine go to preferences and under languages and frameworks select ruby SDK & GEMS and chose the correct version for project. If the correct version of ruby is not installed run `rvm install 2.3.1` replacing the version number with the required version from the GEM file.
