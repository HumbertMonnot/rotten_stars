require 'geocoder'

class PrestationsController < ApplicationController
  before_action :set_prestation, only: [:show, :destroy]
  skip_before_action :authenticate_user!, only: [:home, :index, :new, :show]

  def index
    @user = User.find(params[:user_id])
    @prestations = policy_scope(Prestation).where(user: @user)
    # @average = average(@prestation)
  end

  def home
    @prestations = Prestation.all
    @dico = @prestations.map do |presta|
      {
        id: presta.id,
        polygon: presta.polygon,
        name: presta.name,
        punchline: presta.punchline,
        price: presta.price,
        cloudi: presta.poster.key
      }
    end
    if params[:address].present?
      # @request = Geocoder.search(params[:address])
      @center = [Geocoder.search(params[:address]).first.data["lon"].to_f, Geocoder.search(params[:address]).first.data["lat"].to_f]
      # raise
    end
    authorize(@prestations)

    # filter
    if params[:category_sing].present?
      @prestations = Prestation.where(category: params[:category_sing])
    elsif params[:category_danse].present?
      @prestations = Prestation.where(category: params[:category_danse])
    elsif params[:category_humour].present?
      @prestations = Prestation.where(category: params[:category_humour])
    elsif params[:category_soiree].present?
      @prestations = Prestation.where(category: params[:category_soiree])
    elsif params[:category_entreprise].present?
      @prestations = Prestation.where(category: params[:category_entreprise])
    elsif params[:category_autre].present?
      @prestations = Prestation.where(category: params[:category_autre])
    else
      @prestations = Prestation.all
    end
  end

  def show
    @reservation = Reservation.new
    @info_array =[{
                    lat: @prestation.latitude,
                    lng: @prestation.longitude
                  },
                @prestation.distance]
    authorize(@prestation)
    @average = average(@prestation)
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


  def average(prestation)
    average = []
    prestation.reservations.each do |reservation|
      reservation.reviews.each do |review|
        average << review.rating
      end
    end
    if average.size.positive?
      final_average = average.sum / average.size
      return final_average
    end
    return "0 commentaire"
  end
end
