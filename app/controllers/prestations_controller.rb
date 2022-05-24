class PrestationsController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def index
    @prestations = Prestation.all
  end

  def show
  end

  def new
  end

  def create
  end

  def destroy
  end
end
