require 'LessonHelper'
require 'AwsHelper'
class LessonsController < ApplicationController
  include LessonHelper
  include AwsHelper

  before_action :set_lesson, only: [:show, :update, :destroy]
  before_action :authenticate_token!

  # GET /lessons
  def index
    @lessons = Lesson.where(active: true)

    render json: @lessons
  end

  def no_image_index
    @lessons = Lesson.where(active: true)
    render json: @lessons.to_json(except: [:image, :sec_image])
  end

  # GET /lessons/1
  def show
    render json: @lesson
  end

  # POST /lessons
  def create
    Lesson.new
    Lesson.transaction do
      @lesson = Lesson.create!(lesson_name: params[:lesson_name], summary: params[:summary], total_word: params[:total_word],
                               grade_level: params[:grade_level], lesson_identifier: params[:lesson_identifier])
      unless params[:image].empty?
        @lesson.image = AwsHelper.aws_upload_image(params[:image])
      end
      unless params[:sec_image].empty?
        @lesson.sec_image = AwsHelper.aws_upload_image(params[:sec_image])
      end
    end

    if @lesson.save
      render json: @lesson, status: :created, location: @lesson
    else
      render json: @lesson.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /lessons/1
  def update
    if @lesson.update_attributes(lesson_name: params[:lesson_name], summary: params[:summary], total_word: params[:total_word],
                                 grade_level: params[:grade_level], lesson_identifier: params[:lesson_identifier])

      if params[:image].nil?
        @lesson.image = ''
      elsif params[:image].empty? || params[:image] == @lesson.image
        @lesson.image = @lesson.image
      else
        @lesson.image = AwsHelper.aws_upload_image(params[:image])
      end
      # unless params[:image].empty?
      #   @lesson.image = AwsHelper.aws_upload_image(params[:image])
      # end
      if params[:sec_image].nil?
        @lesson.sec_image = ''
      elsif params[:sec_image].empty? || params[:sec_image] == @lesson.sec_image
        @lesson.sec_image = @lesson.sec_image
      else
        @lesson.sec_image = AwsHelper.aws_upload_image(params[:sec_image])
      end
      # unless params[:sec_image].empty?
      #   @lesson.sec_image = AwsHelper.aws_upload_image(params[:sec_image])
      # end
      @lesson.save
      render json: @lesson
    else
      render json: @lesson.errors, status: :unprocessable_entity
    end
  end

  # DELETE /lessons/1
  def destroy
    @lesson.active = !@lesson.active
    @lesson.save
    render json: @lesson
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_lesson
    @lesson = Lesson.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def lesson_params
    params.require(:lesson).permit(:lesson_name, :summary, :total_word, :grade_level, :lesson_identifier, :image, :sec_image)
  end

end
