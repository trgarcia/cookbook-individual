require 'rails_helper'

describe 'get details of a recipe' do
  it 'Successfully' do
    user = User.create(email:'user@email.com', password:'123456')

    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name:'Brasileira')

    recipe = Recipe.create(title: 'Bolo de cenoura', recipe_type: recipe_type,
                         cuisine: cuisine, difficulty: 'Medio',
                         cook_time: 60,
                         user:user,
                         ingredients: 'Farinha, açucar, cenoura',
                         cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')

    get api_v1_recipe_path(recipe)

    json_recipe = JSON.parse(response.body, symbolize_names:true)

    expect(response.status).to eq 200

    expect(json_recipe[:title]).to eq recipe.title
  end

  it 'not found recipe' do
    get api_v1_recipe_path(id: 1000)

    json_recipe = JSON.parse(response.body, symbolize_names:true)
    #byebug
    expect(response.status).to eq 404
    expect(json_recipe[:messages]).to eq 'Receita não encontrada'
  end
end
