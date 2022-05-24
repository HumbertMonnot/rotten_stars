class PrestationsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @prestations = Prestation.all
  end

  def show
    @prestation = Prestation.find(params[:id])
  end
end
