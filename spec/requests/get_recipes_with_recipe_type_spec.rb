require 'rails_helper'

describe 'Get recipes with recipe type' do
  it 'Successfully' do
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name:'Brasileira')

    user = User.create(email:'user@email.com', password:'123456')
    recipe = Recipe.create(status:1, title: 'Bolo de cenoura', recipe_type: recipe_type,
                           cuisine: cuisine, difficulty: 'Medio',
                           cook_time: 60,
                           user: user,
                           ingredients: 'Farinha, açucar, cenoura',
                           cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')
    get api_v1_recipe_type_path(recipe_type)


    expect(response.status).to eq 200
    expect(response.body).to include 'Bolo de cenoura'
    expect(response.body).to include 'Sobremesa'
  end
  it 'get more od an recipes' do
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name:'Brasileira')

    user = User.create(email:'user@email.com', password:'123456')
    Recipe.create(status:1, title: 'Bolo de cenoura', recipe_type: recipe_type,
                           cuisine: cuisine, difficulty: 'Medio',
                           cook_time: 60,
                           user: user,
                           ingredients: 'Farinha, açucar, cenoura',
                           cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')
    Recipe.create(status:1, title: 'Bolo de laranja', recipe_type: recipe_type,
                          cuisine: cuisine, difficulty: 'Medio',
                          cook_time: 60,
                          user: user,
                          ingredients: 'Farinha, açucar, cenoura',
                          cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')

    get api_v1_recipe_type_path(recipe_type)


    expect(response.status).to eq 200
    expect(response.body).to include 'Bolo de cenoura'
    expect(response.body).to include 'Bolo de laranja'
    expect(response.body).to include 'Sobremesa'
  end
end
