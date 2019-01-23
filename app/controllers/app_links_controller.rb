class AppLinksController < ApplicationController
  before_action :set_app_link, only: [:show, :update, :destroy]
  before_action :authenticate_token!

  # GET /app_links
  def index
    @app_links = AppLink.all.order(:sort_order)

    render json: @app_links
  end

  # GET /app_links/1
  def show
    render json: @app_link
  end

  # POST /app_links
  def create
    @app_link = AppLink.new(app_link_params)

    if @app_link.save
      render json: @app_link, status: :created, location: @app_link
    else
      render json: @app_link.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /app_links/1
  def update
    if @app_link.update(app_link_params)
      render json: @app_link
    else
      render json: @app_link.errors, status: :unprocessable_entity
    end
  end

  # DELETE /app_links/1
  def destroy
    @app_link.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_app_link
      @app_link = AppLink.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def app_link_params
      params.require(:app_link).permit(:title, :description, :link, :sort_order, :icon)
    end
end
