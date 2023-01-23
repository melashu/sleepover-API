class Api::V1::ReservationsController < ApplicationController
  def index
    @reservations = Reservation.all.where(user_id: current_user.id)
  end

  def show
    render json: @reservation, status: :ok
  end

  def new
    @reservation = Reservation.new
  end

  def edit; end

  def create
    @reservation = Reservation.new(reservation_params)

    if @reservation.save
      render json: @reservation, status: :created
    else
      render json: { errors: @reservation.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    return if @reservation.update(reservation_params)

    render json: { errors: @reservation.errors.full_messages },
           status: :unprocessable_entity
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    return unless @reservation.destroy
  end

  private

  def reservation_params
    params.require(:reservation).permit(:start_date, :end_date, :user_id, :room_id)
  end
end
