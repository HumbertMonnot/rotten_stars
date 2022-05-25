class PrestationsController < ApplicationController
  before_action :set_prestation, only: :destroy
  skip_before_action :authenticate_user!, only: [:new, :create, :destroy]

  def new
    @prestation = Prestation.new
  end

  def create
    prestation = Prestation.new(prestation_params)
    prestation.save
    redirect_to prestations_path
  end

  def destroy
    @prestation.destroy
    redirect_to user_prestations_path
  end

  private

  def set_prestation
    @prestation = Prestation.find(params[:id])
  end

  def prestation_params
    params.require(:prestation).permit(:name, :category, :description, :price, :address, :distance, :punchline)
  end
end
