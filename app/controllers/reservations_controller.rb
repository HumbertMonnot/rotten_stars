class ReservationsController < ApplicationController
  before_action :authenticate_user!

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

  def create
    @prestation = Prestation.find(params[:prestation_id])
    @reservation = Reservation.new(reservations_params)
    @reservation.prestation = @prestation
    @reservation.user = current_user
    @reservation.state = "pending"
    @reservation.price = @prestation.price
    duration = (@reservation.end_date - @reservation.start_date).to_i / (3600 * 24) + 1
    @reservation.total = @prestation.price * duration
    if @reservation.save
      redirect_to prestations_path
    else
      render "prestations/show"
    end
  end

  private

  def reservations_params
    params.require(:reservation).permit(:start_date, :end_date, :price, :total, :state)
  end
end
