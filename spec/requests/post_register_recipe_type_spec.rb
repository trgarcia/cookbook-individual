require 'rails_helper'

describe 'Post register recipe type 'do
  it 'Successfully' do

    user = User.create(email:'user@email.com', password:'123456')


    sign_in user


    post "/api/v1/recipe_types/", params: {recipe_type: {name: 'Sobremesa'}}

    json_recipe_type = JSON.parse(response.body, symbolize_names:true)

    expect(response.status).to eq 201
    expect(json_recipe_type[:name]).to eq 'Sobremesa'
  end

  it 'must be fill in' do
    user = User.create(email:'user@email.com', password:'123456')

    sign_in user

    post "/api/v1/recipe_types/", params: {recipe_type: {name: ''}}

    json_recipe_type = JSON.parse(response.body, symbolize_names:true)

    expect(response.status).to eq 412
    expect(json_recipe_type[:messages].first).to eq 'Nome não pode ficar em branco'
  end

  it 'must be unique' do
    user = User.create(email:'user@email.com', password:'123456')

    sign_in user

    RecipeType.create(name:'Sobremesa')


    post "/api/v1/recipe_types/", params: {recipe_type: {name: 'Sobremesa'}}

    json_recipe_type = JSON.parse(response.body, symbolize_names:true)

    expect(response.status).to eq 412
    expect(json_recipe_type[:messages].first).to eq 'Nome já está em uso'
  end

end
