class ReservationsController < ApplicationController
  skip_before_action :authenticate_user!, only: :new

  def index
    @reservations = current_user.reservations
    @user = current_user
  end

  def edit
    @reservation = Reservation.find(params[:id])
  end

  def update
    @reservation = Reservation.find(params[:id])
    @user = User.find(params[:user_id])
    raise
    @reservation.update(reservations_params)
    if @reservation.save
      redirect_to user_reservations_path(@user)
    else
      render :edit
    end
  end

  def new
    @reservation = Reservation.new
    @prestation = Prestation.where(params[:id] == :prestation_id)
  end

  def create
  end

  private

  def reservations_params
    params.require(:reservation).permit(:start_date, :end_date, :price, :total, :state)
  end
end
