class PrestationsController < ApplicationController
  before_action :set_prestation, only: [:show, :destroy]
  skip_before_action :authenticate_user!, only: [:new, :create, :destroy]

  # def index
  #   @user = User.find(params[:user_id])
  #   @prestations = @user.prestations

  def index
    @prestations = Prestation.all
  end

  def show
    @reservation = Reservation.new
  end
  
  def new
    @prestation = Prestation.new
  end

  def create
    prestation = Prestation.new(prestation_params)
    prestation.user = User.find(params[:user_id])
    prestation.save
    redirect_to user_prestations_path(prestation.user)
  end

  def destroy
    @prestation.destroy
    redirect_to user_prestations_path(@prestation.user)
  end

  private

  def set_prestation
    @prestation = Prestation.find(params[:id])
  end

  def prestation_params
    params.require(:prestation).permit(:name, :category, :description, :price, :address, :distance, :punchline)
  end
end
