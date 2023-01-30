class Api::V1::HotelsController < ApplicationController
  load_and_authorize_resource
  before_action :check_hotel, only: %i[destroy show]
  skip_before_action :authenticate_request, only: %i[index show create all_hotel destroy] # remove
  # create, all_hotel, destroy, must be removed

  def index
    hotel = Hotel.includes(:rooms).all.where(rooms: { reserve: false })
    render json: hotel
  end

  def all_hotel
    hotels = Hotel.all
    render json: hotels
  end

  def create
    hotel = Hotel.new(check_param)
    # hotel.user_id = @current_user.id
    if hotel.save
      render json: { message: 'success' }
    else
      render json: { message: 'error', hotel: hotel.errors.full_messages }
    end
  end

  def destroy
    if @hotel.destroy
      render json: { message: 'success' }
    else
      render json: { message: 'error', error: @hotel.errors.full_messages }
    end
  end

  def show
    render json: @hotel
  end

  private

  def check_hotel
    @hotel = Hotel.find(params[:id])
  end

  def check_param
    params.permit(:name, :city, :phone, :country, :image, :detail, :user_id)
  end
end
