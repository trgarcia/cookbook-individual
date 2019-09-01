require 'rails_helper'

describe 'Delete recipe' do
  it 'Successfully' do
    user = User.create(email:'user@email.com', password:'123456')
    cuisine = Cuisine.create(name:'Brasileira')

    recipe_type = RecipeType.create(name:'Sobremesa')

    recipe = Recipe.create(status:1, title: 'Bolo de cenoura', recipe_type: recipe_type,
                           cuisine: cuisine, difficulty: 'Medio',
                           cook_time: 60,
                           user: user,
                           ingredients: 'Farinha, açucar, cenoura',
                           cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')
    delete '/api/v1/recipes/1'

    expect(response.status).to eq 301
    expect(response.body).to include 'Receita deletada'
  end

  it 'recipe must exist' do
    delete '/api/v1/recipes/1'

    expect(response.status).to eq 404
    expect(response.body).to include 'Receita não existe'
  end
end
