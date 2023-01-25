class Api::V1::HotelsController < ApplicationController
  before_action :check_hotel, only: %i[destroy show]
  load_and_authorize_resource

  def index
    hotel = Hotel.includes(:rooms).all.where(rooms: { reserve: false })
    render json: hotel
  end

  def create
    hotel = Hotel.new(check_param)
    hotel.user_id = @current_user.id
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
    params.permit(:name, :city, :phone, :country, :image, :detail)
  end
end
