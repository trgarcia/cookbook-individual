class RecipeListsController < ApplicationController
  def new
    @recipe_list = RecipeList.new
  end

  def create
    @recipe_list = RecipeList.new(params.require(:recipe_list).permit(:name))
    @recipe_list.user = current_user
    if @recipe_list.save
      redirect_to root_path
      flash[:notices] = "Lista criada com sucesso"
    else
      flash.now[:notices] = "Falha ao criar lista"
      render :new
    end
  end

  def my_lists
    @recipe_lists = RecipeList.where(user: current_user)

  end
end
