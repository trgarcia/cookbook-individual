require 'rails_helper'

describe 'User just can delete yours recipes 'do
  it 'Successfully' do
    user = User.create(email:'ser@email.com', password:'123456')
    cuisine = Cuisine.create(name:'rasileira')
    other = User.create(email:'other@email.com',password:'123456')
    recipe_type = RecipeType.create(name:'obremesa')

    recipe = Recipe.create(status:1, title: 'Bolo de cenoura', recipe_type: recipe_type,
                           cuisine: cuisine, difficulty: 'Medio',
                           cook_time: 60,
                           user: user,
                           ingredients: 'Farinha, açucar, cenoura',
                           cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')

    sign_in other

    delete recipe_path(recipe)


    r = Recipe.find(recipe.id)
    
    expect(recipe.id).to eq r.id
    #expect(response.body).to include 'Voce nao pode apagar uma receita que nao e sua'
  end
end
