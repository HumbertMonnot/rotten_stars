class ReservationsController < ApplicationController

  def index
    @user = User.find(params[:user_id])
    @reservations = policy_scope(Reservation)
    @reservations_received= @reservations.select { |resa| resa.prestation.user == current_user }
    @reservations_launched = @reservations.select { |resa| resa.user == current_user }
  end

  def edit
    @reservation = Reservation.find(params[:id])
    @user = User.find(params[:user_id])
    authorize(@user)
  end

  def update
    @reservation = Reservation.find(params[:id])
    @user = @reservation.prestation.user
    @reservation.update(state: params[:state])
    if @reservation.save
      redirect_to user_reservations_path(@user)
    else
      render :edit
    end
    authorize(@user)
  end

  def create
    @prestation = Prestation.find(params[:prestation_id])
    @reservation = Reservation.new(reservations_params)
    @reservation.prestation = @prestation
    @reservation.user = current_user
    authorize(current_user)
    @reservation.state = "pending"
    @reservation.price = @prestation.price
    duration = (@reservation.end_date - @reservation.start_date).to_i / (3600 * 24) + 1
    @reservation.total = @prestation.price * duration
    if @reservation.save
      redirect_to user_path(current_user)
    else
      render "prestations/show"
    end
  end

  private

  def reservations_params
    params.require(:reservation).permit(:start_date, :end_date, :price, :total, :state)
  end
end
