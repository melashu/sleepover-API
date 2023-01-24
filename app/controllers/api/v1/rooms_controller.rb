class Api::V1::RoomsController < ApplicationController
  before_action :set_room, only: %i[show destroy]
  def index
    room = @current_user.rooms
    render json: room
  end

  def create
    room = Room.new(param_checker)
    if room.save
      render json: { message: 'success' }
    else
      render json: { message: 'error' }, status: :unprocessable_entity
    end
  end

  def show
    render json: { message: 'success', room: @room }, status: :ok, except: %i[created_at updated_at] if @room.present?
    render json: { message: 'No record found' }, status: :not_found unless @room.present?
  end

  def destroy
    if @room.destroy
      render json: { message: 'success' }, status: :ok
    else
      render json: { message: 'error' }, status: :unprocessable_entity
    end
  end

  def checkout_reservation
    reservation = Reservation.all.where(archived: false)
    reservation.each do |res|
      diff = (res.end_date - Date.today).to_i
      if diff.negative?
        res.update(archived: true)
        res.room.update(reserve: false)
      end
    end
    render json: { message: 'Success' }
  end


  private

  def param_checker
    params.permit(:room_no, :number_of_bed, :photo, :prices, :user_id, :hotel_id)
  end

  def set_room
    @room = @current_user.rooms.find(params[:id])
  end
end
