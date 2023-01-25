class Api::V1::ReservationsController < ApplicationController
  def index
    reservations = @current_user.reservations.where(archived: false)
    render json: reservations
  end

  def show
    reservation = Reservation.find(params[:id])
    render json: reservation, status: :ok
  end

  def create
    reservation = Reservation.new(reservation_params)
    if reservation.save
      render json: reservation, status: :created
    else
      render json: { errors: reservation.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    reservation = Reservation.find(params[:id])
    render json: { message: 'success' } if reservation.update(reservation_params)
    return if reservation.present?

    render json: { errors: reservation.errors.full_messages },
           status: :unprocessable_entity
  end

  def destroy
    reservation = Reservation.find(params[:id])
    if reservation.destroy
      render json: { message: 'success' }
    else
      render json: { errors: reservation.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def history
    reserved = @current_user.reservations.where(archived: false)
    render json: reserved, status: :created
  end

  private

  def reservation_params
    params.permit(:start_date, :end_date, :user_id, :room_id)
  end
end
