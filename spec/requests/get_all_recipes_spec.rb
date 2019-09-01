require 'rails_helper'

describe 'Get all recipes' do
  it 'sucessfully' do
    recipe_type = RecipeType.create(name: 'Sobremesa')
    user = User.create(email:'user@email.com', password:'123456')
    cuisine = Cuisine.create(name:'Brasileira')

    recipe = Recipe.create(status:1, title: 'Bolo de cenoura', recipe_type: recipe_type,
                           cuisine: cuisine, difficulty: 'Medio',
                           cook_time: 60,
                           user: user,
                           ingredients: 'Farinha, açucar, cenoura',
                           cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')
    other = Recipe.create(status:1, title: 'Bolo de laranja', recipe_type: recipe_type,
                            cuisine: cuisine, difficulty: 'Medio',
                            cook_time: 60,
                            user: user,
                            ingredients: 'Farinha, açucar, cenoura',
                            cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')
    get '/api/v1/recipes/'

    expect(response.status).to eq 200
    expect(response.body).to include 'Bolo de cenoura'
    expect(response.body).to include 'Bolo de laranja'

  end

  it 'filter recipes for parameter with status accepted' do
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name:'Brasileira')

    user = User.create(email:'user@email.com', password:'123456')
    recipe = Recipe.create(status:1, title: 'Bolo de cenoura', recipe_type: recipe_type,
                           cuisine: cuisine, difficulty: 'Medio',
                           cook_time: 60,
                           user: user,
                           ingredients: 'Farinha, açucar, cenoura',
                           cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')
    other = Recipe.create(status:0, title: 'Bolo de laranja', recipe_type: recipe_type,
                            cuisine: cuisine, difficulty: 'Medio',
                            cook_time: 60,
                            user: user,
                            ingredients: 'Farinha, açucar, cenoura',
                            cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')
    get '/api/v1/recipes?status=accepted'

    expect(response.status).to eq 200
    expect(response.body).to include 'Bolo de cenoura'
    expect(response.body).not_to include 'Bolo de laranja'

  end

  it 'filter recipes for parameter with status rejected' do
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name:'Brasileira')

    user = User.create(email:'user@email.com', password:'123456')
    recipe = Recipe.create(status:1, title: 'Bolo de cenoura', recipe_type: recipe_type,
                           cuisine: cuisine, difficulty: 'Medio',
                           cook_time: 60,
                           user: user,
                           ingredients: 'Farinha, açucar, cenoura',
                           cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')
    other = Recipe.create(status:2, title: 'Bolo de laranja', recipe_type: recipe_type,
                            cuisine: cuisine, difficulty: 'Medio',
                            cook_time: 60,
                            user: user,
                            ingredients: 'Farinha, açucar, cenoura',
                            cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')
    get '/api/v1/recipes?status=rejected'

    expect(response.status).to eq 200
    expect(response.body).not_to include 'Bolo de cenoura'
    expect(response.body).to include 'Bolo de laranja'

  end
end
