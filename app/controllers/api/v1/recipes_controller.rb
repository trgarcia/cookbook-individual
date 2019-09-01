class Api::V1::RecipesController < Api::V1::ApiController
  before_action :authenticate_user!, only: %i[accepted rejected]
  before_action :get_id, only: %i[accepted rejected]
  def show
    @recipe = Recipe.find(params[:id])
    render json: @recipe, status: :ok

  rescue ActiveRecord::RecordNotFound
    render json:  {messages:'Receita não encontrada'}, status: :not_found
  end

  def create
    @recipe = Recipe.new(params.require(:recipe).permit(:q, :imagem,  :title, :recipe_type_id, :cuisine_id, :difficulty, :cook_time, :ingredients, :cook_method, :user_id))

    if @recipe.save
      render json: @recipe, status: :created
    else
      render json: {messages: @recipe.errors.full_messages}, status: 412
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])

    @recipe.destroy
    render json: {message: 'Receita deletada'}, status: 301

  rescue ActiveRecord::RecordNotFound
    render json: {message: 'Receita não existe'}, status: 404
  end

  def accepted
    @recipe.accepted!

    render json: @recipe, status: 202
  end

  def rejected
    @recipe.rejected!

    render json: @recipe, status: 202
  end

  def recipes
    if params[:status]
      @recipes = Recipe.where(status: params[:status])
    else
      @recipes = Recipe.all
    end
    render json: @recipes, status: 200
  end

  private

  def get_id
    @recipe = Recipe.find(params[:id])
  end


end
