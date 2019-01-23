Rails.application.routes.draw do
  namespace :swagger do
    resources :apidocs, only: [:index]
  end

  resources :absences
  resources :districts
  resources :lastuserimports
  resources :resolutions
  resources :feedbacks
  resources :app_links
  resources :dra_records
  resources :averages
  resources :events
  devise_for :users
  resources :sessions
  resources :students
  resources :lessons
  resources :schools
  resources :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/api-documentation' => redirect('/swagger/dist/index.html?url=/swagger/apidocs.json')
  # token registration
  post 'volunteer/login'   => 'authentication#create'

  # Reporting
  # get 'districts' => 'districts#gen_report'
  post 'district_report' => 'reports#district_report'
  post 'run_report'      => 'reports#gen_report'
  post 'import'          => 'dra_records#import_record'
  get 'temp_report'      => 'reports#temp_report'
  post 'students_by_year/:id' => 'schools#students_by_year'
  get 'student_report/:id'    => 'students#student_report'
  post 'tutor_report/:district_id/:school_id/:tutor_id' => 'tutor_report#tutor_report'

  # volunteer
  post 'new/volunteer' => 'users#create'
  get  'all/volunteers' => 'users#index'
  get  'volunteer/:user_id' => 'users#show'
  get  'all/volunteers/simple' => 'users#simple_index'
  get  'all/volunteers/web' => 'users#index_web'
  get  'inactive/volunteers' => 'users#index_inactive_web'
  put  'volunteer/set_activity/:user_id' => 'users#set_activity'
  put  'update/volunteer/:user_id' => 'users#update'
  delete 'delete/volunteer/:user_id' => 'users#destroy'
  get  'self' => 'users#self'
  post 'updatepass' => 'users#reset_password'
  put  'update/active' => 'users#batch_activate'
  put  'batch/shadow' => 'users#batch_shadow'
  post 'tutor_action' => 'users#tutor_actions'

  # passwords
  put 'reset/:token' => 'passwords#set_password'

  # students

  get 'list_students/:sort_by' => 'students#index'
  get 'list_students_web/:sort_by' => 'students#index_web'
  get 'list_students_web' => 'students#index_web'
  get 'undone_lesson_list/:id' => 'students#list_undone'
  get 'student/setup/:id' => 'students#start_session'
  get 'inactive/students' => 'students#index_inactive'
  get 'student/web_show/:id' => 'students#show_web'
  put 'deactivate/student/:id' => 'students#set_inactive'
  put 'reactivate/student/:id' => 'students#reactivate'
  get 'average_mood' => 'students#average_mood'
  post 'import_students/:school_id' => 'students#import_students'
  post 'advance_all_students/:school_id' => 'students#advance_all_students'
  post 'advance_student_group' => 'students#advance_students'
  post 'revert_student_group' => 'students#revert_students'
  post 'student_action' => 'students#student_actions'

  #lessons

  get 'lessons_no_image' => 'lessons#no_image_index'
  post 'lesson_s3' => 'lessons#create_s3'
  get 'lesson_s3/test_s3' => 'lessons#test_s3'

  #sessions
  post 'session/new' => 'sessions#create_new'
  get 'com_sessions/:id' => 'sessions#show_sessions'

  # averages
  get 'school_averages/:school_id' => 'averages#average_acumen'

  #schools
  get 'schools_no_students' => 'schools#index_school_no_student'

end
