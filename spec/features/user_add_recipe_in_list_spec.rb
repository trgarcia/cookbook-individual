require 'rails_helper'

feature 'User add recipe in list' do
  scenario 'Successfully' do
    user = User.create(email:'user@email.com', password:'123456')
    recipe_type = RecipeType.create(name: 'Sobremesa')
    RecipeList.create(name:'Churras',user:user)
    recipe = Recipe.create(status:1, title: 'Bolo de cenoura', recipe_type: recipe_type,
                           cuisine: 'Brasileira', difficulty: 'Medio',
                           cook_time: 60,
                           user: user,
                           ingredients: 'Farinha, açucar, cenoura',
                           cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')

    visit root_path

    click_on 'Entrar'

    within('form')do
      fill_in 'Email', with:user.email
      fill_in 'Senha', with:'123456'
      click_on 'Entrar'
    end

    click_on recipe.title

    select 'Churras', from: 'Listas do usuario'
    click_on 'Adicionar a lista'

    expect(page).to have_content 'Receita adicionada a lista Churras'
    expect(page).to have_css('p', text:'Churras')

  end
end
