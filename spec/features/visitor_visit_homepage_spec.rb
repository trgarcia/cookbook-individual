require 'rails_helper'

feature 'Visitor visit homepage' do
  scenario 'sucessifully' do
    #arrange
    #act
    visit root_path
    #assert
    expect(page).to have_css('h1', text:'CookBook')
    expect(page).to have_css('p', text:'Bem-vindo ao maior livro de receitas online')
  end
  scenario 'Visitante visualiza receitas na pagina inicial' do
    #arrange
    recipe_type = RecipeType.create(name: 'Sobremesa')
    recipe = Recipe.create(title:'Bolo de cenoura',recipe_type:recipe_type,cuisine:'Brasileira',
                            difficulty:'Media',cook_time:60, ingredients:'dggwg', cook_method:'fwefwefew')
    #act
    visit root_path
    #assert
    expect(page).to have_css('h1', text:recipe.title)
    expect(page).to have_css('li', text:recipe.recipe_type.name)
    expect(page).to have_css('li', text:recipe.cuisine)
    expect(page).to have_css('li', text:recipe.difficulty)
    expect(page).to have_css('li', text:"#{recipe.cook_time}minutos")

  end
end
