class PrestationsController < ApplicationController

  def index
    @user = User.find(params[:user_id])
    @prestations = @user.prestations
  end
end
