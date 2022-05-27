class UsersController < ApplicationController
  # before_action :find_user, only: [ :prestation ]

  def past_reservations
    @user = User.find(params[:id])
    @list_past_reservations = @user.reservations.where("end_date <= ?", Date.today)
    authorize(@user)
  end

  def show
    @user = User.find(params[:id])
    # @prestation_user = current_user.prestations
    authorize(@user)
    # message?()
  end

  private

  def find_prestations
    @prestation_user = Prestation.find(params[:id])
  end

  # def message?
    # prestation_message = []
    # @user.prestations.each do |prestation|
      # prestation_message << prestation
    # end
    # raise
    # true if prestation_message.positive?
  # end
end
