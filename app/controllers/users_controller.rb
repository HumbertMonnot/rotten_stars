class UsersController < ApplicationController
  def past_reservations
    @user = User.find(params[:id])
    @past_reservations = @user.reservations.where("end_date <= ?", Date.today)
  end

  def show
    @user = User.find(params[:id])
  end
end
