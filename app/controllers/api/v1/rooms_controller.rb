class Api::V1::RoomsController < ApplicationController
  before_action :check_room, only: %i[show destroy]
  load_and_authorize_resource
  def index
    rooms = Room.all
    # hotel = Hotel.includes(:rooms).all.where(rooms:{reserve: false})

    render json: rooms
    # render json: {room: rooms}
  end

  def create
    room = Room.new(param_checker)
    room.user_id = @current_user.id
    if room.save
      render json: { message: 'success' }
    else
      render json: { message: 'error', errro: room.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    # render json: { message: 'success', room: @room }, status: :ok if @room.present?
    render json: @room, status: :ok if @room.present?
    render json: { message: 'error', error: 'Record not found' }, status: :not unless @room.present?
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
    render json: { message: 'success' }
  end

  private

  def param_checker
    params.permit(:room_no, :number_of_bed, :photo, :prices, :hotel_id)
  end

  def check_room
    @room = Room.find(params[:id])
  end
end
