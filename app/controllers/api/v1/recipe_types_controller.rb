class Api::V1::RecipeTypesController < Api::V1::ApiController
  before_action :authenticate_user!, only: %i[create]
  def create
    @recipe_type = RecipeType.new(params.require(:recipe_type).permit(:name))

    if @recipe_type.save
      render json: @recipe_type , status: :created
    else

      render json: {messages: @recipe_type.errors.full_messages} , status: 412
    end
  end

  def show
    @recipes = Recipe.where(recipe_type_id: params[:id])

    render json: {recipes: @recipes, recipe_type: @recipes.first.recipe_type} , status: 200

  end

end
