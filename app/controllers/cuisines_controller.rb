class CuisinesController < ApplicationController
  before_action :authenticate_user!
  before_action :is_admin?
  def new
    @cuisine = Cuisine.new
  end

  def create
    @cuisine = Cuisine.new(params.require(:cuisine).permit(:name))
    if @cuisine.save
      flash[:cuisine] = 'Cozinha cadastrada com sucesso!'
      redirect_to root_path
    else
      flash.now[:cuisine] = @cuisine.errors.full_messages.first
      render :new
    end
  end

  private
  def is_admin?
    if !current_user.admin
      redirect_to root_path
    end
  end
end
