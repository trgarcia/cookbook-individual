class RecipesController < ApplicationController
  before_action :get_id, only: %i[show edit update add_to_list delete_to_list approve reject destroy ]
  before_action :authenticate_user! , only: %i[new create edit update pendings approve destroy]
  def index
    @recipes = Recipe.accepted()
  end

  def search
    @recipes = Recipe.where('title like ?',"%#{params[:q]}%")
    if @recipes.empty?
      flash.now[:alert] = 'Receita nao encontrada'
    end
  end

  def show

    @recipe_recipe_list = RecipeRecipeList.new
    @recipe_lists = RecipeList.where(user: current_user )

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

  def destroy
    if current_user == @recipe.user
      @recipe.destroy
      flash[:notice] = "Receita apagada"
      redirect_to user_recipes_path
    else
      redirect_to root_path
    end
  end

  def user_recipes
    @recipes = Recipe.where(user: current_user)
  end

  def add_to_list


    @recipe_list = RecipeList.find(params[:recipe_recipe_list][:recipe_list_id])


    @recipe_recipe_list = RecipeRecipeList.new(recipe:@recipe, recipe_list:@recipe_list)
    if @recipe_recipe_list.save
      flash[:notice] = "Receita adicionada a lista #{@recipe_list.name}"
    else
      flash[:notice] = "Receita nao pode ser adicionada a lista #{@recipe_list.name}"
    end
    redirect_to @recipe
  end

  def delete_to_list

  end

  def pendings
    @pendings = Recipe.pending
  end

  def approve
    @recipe.accepted!
    flash[:notice] = "Receita aceita"
    redirect_to pendings_path
  end

  def reject
    @recipe.rejected!
    flash[:notice] = "Receita rejeitada"
    redirect_to pendings_path
  end

  private

  def set_params
    params.require(:recipe).permit(:q, :imagem,  :title, :recipe_type_id, :cuisine_id, :difficulty, :cook_time, :ingredients, :cook_method)
  end

  def get_id
    @recipe = Recipe.find(params[:id])
  end



end
