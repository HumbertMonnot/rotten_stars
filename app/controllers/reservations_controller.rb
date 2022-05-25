class ReservationsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @reservations = @user.reservations
  end

  def edit
    @reservation = Reservation.find(params[:id])
  end

  def update
    @reservation = Reservation.find(params[:id])
    @user = User.find(params[:user_id])
    @reservation.update(state: params[:state])
    if @reservation.save
      redirect_to user_reservations_path(@user)
    else
      render :edit
    end
  end

  private

  def reservations_params
    params.require(:reservation).permit(:start_date, :end_date, :price, :total, :state)
  end
end
