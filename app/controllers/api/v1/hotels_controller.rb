class Api::V1::HotelsController < ApplicationController
  before_action :set_hotel, only: %i[destroy show]
  def index
    hotel = @current_user.hotels

    render json: hotel if hotel.any?
    render json: { message: 'empty' } unless hotel.any?
  end

  def create
    hotel = Hotel.new(check_param)
    if hotel.save
      render json: { message: 'success' }
    else
      render json: { message: 'error', hotel: }
    end
  end

  def destroy
    if @hotel.destroy
      render json: { message: 'success' }
    else
      render json: { message: 'error' }
    end
  end

  def show
    render json: { message: 'success', hotel: @hotel }
  end

  private

  def set_hotel
    @hotel = @current_user.hotels.find(params[:id])
  end

  def check_param
    params.permit(:name, :city, :phone, :user_id, :country, :image)
  end
end
