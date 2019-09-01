require 'rails_helper'

describe 'post alter status os recipe' do
  it 'status alter for accepted' do
    recipe_type = RecipeType.create(name: 'Sobremesa')
    user = User.create(email:'user@email.com', password:'123456')
    cuisine = Cuisine.create(name:'Brasileira')

    recipe = Recipe.create(status:1, title: 'Bolo de cenoura', recipe_type: recipe_type,
                           cuisine: cuisine, difficulty: 'Medio',
                           cook_time: 60,
                           user: user,
                           ingredients: 'Farinha, açucar, cenoura',
                           cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')
    sign_in user

    post '/api/v1/recipes/1/accepted'

    json_recipe = JSON.parse(response.body, symbolize_names:true)

    expect(response.status).to eq 202
    expect(json_recipe[:status]).to eq 'accepted'
  end

  it 'status alter for rejected' do
    recipe_type = RecipeType.create(name: 'Sobremesa')
    user = User.create(email:'user@email.com', password:'123456')
    cuisine = Cuisine.create(name:'Brasileira')

    recipe = Recipe.create(status:1, title: 'Bolo de cenoura', recipe_type: recipe_type,
                           cuisine: cuisine, difficulty: 'Medio',
                           cook_time: 60,
                           user: user,
                           ingredients: 'Farinha, açucar, cenoura',
                           cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')
    sign_in user

    post '/api/v1/recipes/1/rejected'

    json_recipe = JSON.parse(response.body, symbolize_names:true)

    expect(response.status).to eq 202
    expect(json_recipe[:status]).to eq 'rejected'
  end
end
