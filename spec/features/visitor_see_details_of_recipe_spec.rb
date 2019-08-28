require 'rails_helper'

feature 'visitor see details of recipe' do
  scenario 'sucessifully' do
    recipe_type = RecipeType.create(name: 'Sobremesa')
    user = User.create(email:'user@email.com',password:'123465')
    recipe = Recipe.create(status:1, title: 'Bolo de cenoura', recipe_type: recipe_type,
                           cuisine: 'Brasileira', difficulty: 'Medio',
                           cook_time: 60,
                           user:user,
                           ingredients: 'Farinha, açucar, cenoura',
                           cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')

    visit root_path
    click_on recipe.title

    expect(page).to have_css('h1', text:recipe.title)
    expect(page).to have_css('p', text:recipe.recipe_type.name)
    expect(page).to have_css('p', text:recipe.cuisine)
    expect(page).to have_css('p', text:recipe.difficulty)
    expect(page).to have_css('p', text:"#{recipe.cook_time} minutos")
    expect(page).to have_css('p', text:recipe.ingredients)
    expect(page).to have_css('p', text:recipe.cook_method)
  end
  scenario 'And return to recipe list'do
    recipe_type = RecipeType.create(name: 'Sobremesa')
    user = User.create(email:'user@email.com',password:'123465')
    recipe = Recipe.create(status:1, title: 'Bolo de cenoura', recipe_type: recipe_type,
                         cuisine: 'Brasileira', difficulty: 'Medio',
                         cook_time: 60,
                         user:user,
                         ingredients: 'Farinha, açucar, cenoura',
                         cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')

    visit root_path
    click_on recipe.title
    click_on 'Voltar'

    expect(current_path).to eq(root_path)
  end

  
end
