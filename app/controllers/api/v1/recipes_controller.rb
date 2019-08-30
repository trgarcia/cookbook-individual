class Api::V1::RecipesController < Api::V1::ApiController
  def show
    @recipe = Recipe.find(params[:id])
    render json: @recipe, status: :ok
  end
end
