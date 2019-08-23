require 'rails_helper'

feature 'Visit search recipes ' do
  scenario 'Successfully' do
    recipe_type = RecipeType.create(name: 'Sobremesa')
    user = User.create(email:'user@email.com',password:'123465')
    recipe = Recipe.create(title: 'Bolo de cenoura', recipe_type: recipe_type,
                           cuisine: 'Brasileira', difficulty: 'Medio',
                           cook_time: 60,
                           user: user,
                           ingredients: 'Farinha, açucar, cenoura',
                           cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')
   recipe = Recipe.create(title: 'Bolo de laranja', recipe_type: recipe_type,
                          cuisine: 'Brasileira', difficulty: 'Medio',
                          cook_time: 60,
                          user: user,
                          ingredients: 'Farinha, açucar, cenoura',
                          cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')

    visit root_path

    fill_in 'Pesquisar', with: 'Bolo de cenoura'
    click_on 'Pesquisar'

    expect(page).to have_content('Bolo de cenoura')
    expect(page).not_to have_content('Bolo de laranja')

  end
  scenario 'search recipe for name exato and not encontrar' do
    visit root_path

    fill_in 'Pesquisar', with: 'Bolo de cenoura'
    click_on 'Pesquisar'

    expect(page).to have_content('Receita nao encontrada')

  end

  scenario 'search recipe for name partial and encontrar more of one' do
    recipe_type = RecipeType.create(name: 'Sobremesa')
    user = User.create(email:'user@email.com',password:'123465')
    Recipe.create(title: 'Bolo de cenoura', recipe_type: recipe_type,
                           cuisine: 'Brasileira', difficulty: 'Medio',
                           cook_time: 60,
                           user: user,
                           ingredients: 'Farinha, açucar, cenoura',
                           cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')
   Recipe.create(title: 'Bolo de laranja', recipe_type: recipe_type,
                          cuisine: 'Brasileira', difficulty: 'Medio',
                          cook_time: 60,
                          user:user,
                          ingredients: 'Farinha, açucar, cenoura',
                          cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')
  Recipe.create(title: 'Torta de laranja', recipe_type: recipe_type,
                         cuisine: 'Brasileira', difficulty: 'Medio',
                         cook_time: 60,
                         user:user,
                         ingredients: 'Farinha, açucar, cenoura',
                         cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')

    visit root_path

    fill_in 'Pesquisar', with: 'Bolo'
    click_on 'Pesquisar'

    expect(page).to have_content('Bolo de cenoura')
    expect(page).to have_content('Bolo de laranja')
    expect(page).not_to have_content('Torta de laranja')
  end
end
