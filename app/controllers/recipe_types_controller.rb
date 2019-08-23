class RecipeTypesController < ApplicationController
  def new
    @recipe_type = RecipeType.new
  end

  def create
    @recipe_type = RecipeType.new(set_params)
    if @recipe_type.save
      redirect_to @recipe_type
    else
      if @recipe_type.name == ''
        flash.now[:alert] = 'Voce deve preencher o campo nome'

      else
        flash.now[:alert] = 'Esse tipo de receita ja existe'
      end
      render :new
    end
  end

  def show
    @recipe_type = RecipeType.find(params[:id])
  end

  private

  def set_params
    params.require(:recipe_type).permit(:name)
  end
end
