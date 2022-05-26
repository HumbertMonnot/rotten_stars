class ReviewsController < ApplicationController

  def new
    @review = Review.new
    @reservation = Reservation.find(params[:reservation_id])
    authorize(@review)
  end

  def create
    @review = Review.new(review_params)
    @reservation = Reservation.find(params[:reservation_id])
    @review.reservation = @reservation
    @review.user = current_user
    authorize(current_user)
    if @review.save
      redirect_to prestation_path(@reservation.prestation.id)
    else
      render :new
    end
  end

  private

  def review_params
    params.require(:review).permit(:comment, :rating)
  end
end
