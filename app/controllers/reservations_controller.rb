class ReservationsController < ApplicationController
  def index
    @reservations = Reservation.all.where(user_id: current_user.id)
  end

  def new
    @reservation = Reservation.new
  end

  def create
    reservation = Reservation.new(reservation_params)
    if reservation.save
      redirect_to root_path, notice: 'Reservation was successfully created.'
    else
      render :new, status: 422
    end
  end

  def destroy
    reservation = Reservation.find(params[:id])
    return unless reservation.destroy

    redirect_to root_path, notice: 'Reservation was successfully deleted.'
  end

  private

  def reservation_params
    params.require(:reservation).permit(:start_date, :end_date, :user_id, :room_id)
  end
end
