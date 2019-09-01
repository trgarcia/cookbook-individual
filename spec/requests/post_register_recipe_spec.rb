require 'rails_helper'

describe 'post register recipes' do
  it 'Successfully' do
    user = User.create(email:'user@email.com', password:'123456')
    recipe_type = RecipeType.create(name:'Sobremesa')
    cuisine = Cuisine.create(name:'Brasileira')

    post '/api/v1/recipes/', params: {recipe: {title: 'Bolo de cenoura', recipe_type_id: recipe_type.id ,cuisine_id: cuisine.id, difficulty: 'Médio', ingredients: 'Ovo', cook_time: 60, cook_method: 'Cozinhe', user_id: user.id}}

    json_recipe = JSON.parse(response.body, symbolize_names:true)

    expect(json_recipe[:title]).to eq 'Bolo de cenoura'
  end

  it 'must be fill in all campus' do
    cuisine = Cuisine.create(name:'Brasileira')

    user = User.create(email:'user@email.com', password:'123456')
    recipe_type = RecipeType.create(name:'Sobremesa')

    post '/api/v1/recipes/', params: {recipe: {title: '', recipe_type_id: recipe_type.id ,cuisine_id: cuisine.id, difficulty: 'Médio', ingredients: 'Ovo', cook_time: 60, cook_method: 'Cozinhe', user_id: user.id}}

    json_recipe = JSON.parse(response.body, symbolize_names:true)

    expect(json_recipe[:messages].first).to eq 'Título não pode ficar em branco'
  end


end
