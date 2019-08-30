require 'rails_helper'

describe 'get details of a recipe' do
  it 'Successfully' do
    user = User.create(email:'user@email.com', password:'123456')

    recipe_type = RecipeType.create(name: 'Sobremesa')
    recipe = Recipe.create(title: 'Bolo de cenoura', recipe_type: recipe_type,
                         cuisine: 'Brasileira', difficulty: 'Medio',
                         cook_time: 60,
                         user:user,
                         ingredients: 'Farinha, açucar, cenoura',
                         cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')

    get api_v1_recipe_path(recipe)

    json_recipe = JSON.parse(response.body, simbolize_names:true)

    expect(response.status).to eq 200

    expect(json_recipe["title"]).to eq recipe.title
  end
end
