class UsersController < ApplicationController
  # scope :past_reservations, -> { where("end_date::date < #{Date.now}") }

  def past_reservations
    @user = User.find(params[:id])
    @past_reservations = @user.reservations.where("end_date <= ?", Date.today)
  end
end
