class ReviewsController < ApplicationController

  def index
    # si user ayant une prestation.
    if current_user == @prestations[:user_id]
      # presta_reviews = []
      # Trier tous les commmentaires par prestation lui appartenant
      @prestations[current_user].each do |prestation|
        @reviews.where(@reviews[:prestation_id] == prestation).last(3) # presta_reviews <<
      end
      # Afficher les 3 derniers commentaires.
      # render presta_reviews.last(3)
    end
    @reviews = Review.where(params[:user_id] == current_user)
    redirect_to users_path(current_user)

    # Afficher le rating moyen total de sa prestation.

  end

  def show

  end

  def create
    @user = User.find(params[:user_id])
    @reservation = Reservation.find(params[:reservation_id])
    @review.user.reservation = Review.new(review_params)
    @prestation = @reservation[:prestation_id]

    if @review.save
      redirect_to prestation_path(@prestation)
    else
      @reviews = @user.reviews
      render "users"
    end
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end
