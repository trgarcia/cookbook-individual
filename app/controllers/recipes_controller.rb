class RecipesController < ApplicationController
  before_action :get_id, only: %i[show edit update]
  before_action :authenticate_user! , only: %i[new create]
  def index
    @recipes = Recipe.all()
  end

  def search
    @recipes = Recipe.where('title like ?',"%#{params[:q]}%")
    if @recipes.empty?
      flash.now[:alert] = 'Receita nao encontrada'
    end
  end
  def show

  end

  def new
    @recipe = Recipe.new
  end

  def create
    @user = current_user
    @recipe = Recipe.new(set_params)
    @recipe.user = @user

    if @recipe.save
      redirect_to @recipe
    else
      flash.now[:alert] = 'Voce deve preencher todos os campos'
      render :new
    end
  end

  def edit

  end

  def update
    @recipe.update(set_params)

    redirect_to @recipe
  end

  private

  def set_params
    params.require(:recipe).permit(:q, :title, :recipe_type_id, :cuisine, :difficulty, :cook_time, :ingredients, :cook_method)
  end

  def get_id
    @recipe = Recipe.find(params[:id])
  end


end
