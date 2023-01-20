class ReservationsController < ApplicationController

  before_action :set_author

  def index
   @reservations= Reservation.all.where(user_id: current_user.id)
  end  

  def new
   @reservation =  Reservation.new
  end  

  def create
    reservation =  Reservation.new(reservation_params)
    if reservation.save
        redirect_to root_path, notice: 'Reservation was successfully created.'
    else
        render :new, status: 422
    end
  end

  private

  def set_author
    @author = current_user
  end

  def reservation_params
    params.require(:reservation).permit(:start_date, :end_date, :user_id, :room_id)
  end  
end
