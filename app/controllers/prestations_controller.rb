class PrestationsController < ApplicationController
  before_action :set_prestation, only: [:show, :destroy]
  skip_before_action :authenticate_user!, only: [:home, :index, :new, :show]

  def index
    @user = User.find(params[:user_id])
    @prestations = policy_scope(Prestation).where(user: @user)
  end

  def home
    @prestations = Prestation.all
    authorize(@prestations)
  end

  def show
    @reservation = Reservation.new
    authorize(@prestation)
  end

  def new
    @prestation = Prestation.new
    @user = User.find(params[:user_id])
    authorize(@user)
  end

  def create
    @prestation = Prestation.new(prestation_params)
    @prestation.user = current_user
    authorize(current_user)
    if @prestation.save
      redirect_to user_path(current_user)
    else
      render :new
    end
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
