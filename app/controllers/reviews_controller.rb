class ReviewsController < ApplicationController

  def new
    @reservation = Reservation.find(params[:reservation_id])
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @reservation = Reservation.find(params[:reservation_id])
    @review.reservation = @reservation
    @review.user = current_user

    if @review.save
      redirect_to prestation_path(@prestation)
    else
      render :new
    end
  end

  private

  def review_params
    params.require(:review).permit(:comment, :rating)
  end
end
