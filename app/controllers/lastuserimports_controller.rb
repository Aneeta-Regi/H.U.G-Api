class LastuserimportsController < ApplicationController
  before_action :set_lastuserimport, only: [:show, :update, :destroy]
  before_action :authenticate_token!

  # GET /lastuserimports
  def index
    @lastuserimports = Lastuserimport.all

    render json: @lastuserimports
  end

  # GET /lastuserimports/1
  def show
    render json: @lastuserimport
  end

  # POST /lastuserimports
  def create
    @lastuserimport = Lastuserimport.new(lastuserimport_params)

    if @lastuserimport.save
      render json: @lastuserimport, status: :created, location: @lastuserimport
    else
      render json: @lastuserimport.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /lastuserimports/1
  def update
    if @lastuserimport.update(lastuserimport_params)
      render json: @lastuserimport
    else
      render json: @lastuserimport.errors, status: :unprocessable_entity
    end
  end

  # DELETE /lastuserimports/1
  def destroy
    @lastuserimport.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lastuserimport
      @lastuserimport = Lastuserimport.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def lastuserimport_params
      params.require(:lastuserimport).permit(:group_id, :memberarray, :member_id)
    end
end
