class UsersController < ApplicationController

  def past_reservations
    @user = User.find(params[:id])
    @list_past_reservations = @user.reservations.where("end_date <= ?", Date.today)
    authorize(@user)
  end

  def show
    @user = User.find(params[:id])
    authorize(@user)
  end
end
