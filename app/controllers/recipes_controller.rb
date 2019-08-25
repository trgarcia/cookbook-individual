class RecipesController < ApplicationController
  before_action :get_id, only: %i[show edit update]
  before_action :authenticate_user! , only: %i[new create edit update]
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
    @recipe_recipe_list = RecipeRecipeList.new
    @recipe_lists = RecipeList.where(user: current_user)
    @recipe_recipe_lists = RecipeRecipeList.where(recipe: @recipe)
  end

  def new
    @recipe = Recipe.new
  end

  def create

    @recipe = Recipe.new(set_params)
    @recipe.user = current_user

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

  def user_recipes
    @recipes = Recipe.where(user: current_user)
  end

  def add_to_list
    @recipe = Recipe.find(params[:id])
    @recipe_list = RecipeList.find(params[:recipe_recipe_list][:recipe_list_id])
    RecipeRecipeList.create(recipe:@recipe, recipe_list:@recipe_list)
    flash[:notice] = "Receita adicionada a lista #{@recipe_list.name}"
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
