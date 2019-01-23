class UsersController < ApplicationController

  before_action :set_user, only: [:update, :show, :set_activity, :destroy, :check_self_update]
  before_action :authenticate_token!, except: [:create, :reset_password]
  before_action :check_self_update, only: [:update]


  # GET /users
  def index
    @users = User.where(active: true).order(:first_name)
    render json: @users
  end

  def index_web
    @users = User.where(active: true).order(:first_name)
    render json: @users, each_serializer: UserSerializerWebIndex
  end

  def index_inactive_web
    @users = User.where(active: false).order(:first_name)
    render json: @users, each_serializer: UserSerializerWebIndex
  end

  def simple_index
    sort_by = :active, :first_name
    @users = User.all.order(sort_by)
    render json: @users, each_serializer: UserSerializerNew
  end

  # GET /users/1
  def show
    # hide the user phone information if share phone is false.
    if @user.share_phone?
      render json: @user.as_json(except: [:password], include: [:students, :schools])
    else
      render json: @user.as_json(except: [:password, :phone, :second_phone], include: [:students, :schools])
    end
  end

  def self
    render json: @current_user.as_json(except: [:passwords])
  end


  # POST /users
  def create
    params_base = user_params
    params_base.delete :image
    @user = User.new(params_base)
    @user.school_id.each do |s|
      school = School.find(s)
      @user.schools << school
    end
    @user.active = true
    unless params[:image].empty?
      @user.image = AwsHelper.aws_upload_image(params[:image])
    end
    @user.send_reset_password_instructions

    if @user.save
      UserMailer.welcome_email(@user).deliver_now
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end


  # define the tutor actions and call the methods
  def tutor_actions
    case params[:thing_to_do]
      when 'Activate'
        activate_tutors
      when 'Deactivate'
        deactivate_tutors
      else
        message = { message: 'That action is not defined.' }
        render json: message, status: :unprocessable_entity
    end
  end

  def activate_tutors
    tutors = User.where(id: params[:tutor_ids])
    tutors.each do |t|
      t.active = true
      UserMailer.welcome_email(t).deliver_now
      t.send_reset_password_instructions
      t.save
    end
  end

  def deactivate_tutors
    tutors = User.where(id: params[:tutor_ids])
    tutors.each do |t|
      t.active = false
      t.save
    end
  end

  def batch_shadow
    users = User.all
    users.each do |u|
      u.completed_shadow_days = true
      u.save
    end
  end

  # this allows for deactivate and reactivate in a single call. because this is a boolean we can simply set the attribute to the
  # opposite of what it currently is.
  # make this send an email when marking active.
  def set_activity
    @user.active = !@user.active
    if @user.active
      UserMailer.welcome_email(@user).deliver_now
      @user.send_reset_password_instructions
    end
    @user.save
  end


  # PATCH/PUT /users/1
  def update
    update_schools
    update_students
    params_base = user_params
    params_base.delete :image
    params_base.delete :password
    if !@user.active && params[:active]
      set_activity
    end
    @user.update(params_base)
    if params[:image].nil?
      @user.image = ''
    elsif params[:image].empty? || params[:image] == @user.image
      @user.image = @user.image
    else
      @user.image = AwsHelper.aws_upload_image(params[:image])
      # params[:image].empty? ? @user.image = @user.image : @user.image = AwsHelper.aws_upload_image(params[:image])
    end
    if @user.save
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # regular users should not be able to edit other users info.
  def check_self_update
    if @current_user.specialist || @current_user.persona == 'admin' || @user.id == @current_user.id
      update
    else
      render json: {errors: ResponseHelper::BAD_TOKEN}, status: :unauthorized
    end
  end

  def update_students
    if @user.first_name != params[:first_name] || @user.last_name != params[:last_name] || @user.phone != params[:phone]
      students = Student.where(user_id: @user.id)
      unless students.nil?
        students.each do |s|
          s.vol_name = params[:first_name] + ' ' + params[:last_name]
          s.vol_phone = params[:phone]
          s.save
        end
      end
    end
    p 'were good on students'
  end

  def update_schools
    if @user.school_id != params[:school_id]
      @user.schools = []
      @user.school_id = params[:school_id]
      @user.school_id.each do |s|
        school = School.find(s)
        @user.schools << school
      end
    else
      p 'were good on schools'
    end
  end


  def reset_password
    unless (user = User.find_by_email(user_params[:email])).nil?
      user.send_reset_password_instructions
      head :no_content
    else
      render json: {errors: User::ERROR_INVALID_ID_EMAIL}, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.active = false
    @user.save
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:user_id])
    #  @user = @current_user
  end


  # Only allow a trusted parameter "white list" through.
  def user_params
    params.require(:user).permit(:first_name, :last_name, :commitment_level,
                                 :phone, :email, :second_phone, :persona,
                                 :specialist, :teacher_exp, :counselor_exp,
                                 :active, :background_check, :code_of_ethics,
                                 :completed_shadow_days, :e_first_name,
                                 :e_last_name, :share_phone, :emergency_contact_number,
                                 :image, :notes, :student_matching_level, :thing_to_do,
                                 :password, :tutor_ids => [], :school_id => [])
  end
end
