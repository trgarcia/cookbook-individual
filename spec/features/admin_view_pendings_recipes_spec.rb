require 'rails_helper'

feature ' Admin view pendings recipes ' do
  scenario ' Successfully' do
    admin = User.create(email:'admin@email.com', password:'123456', admin:true)

    recipe_type = RecipeType.create(name: 'Sobremesa')
    recipe = Recipe.create(title: 'Bolo de cenoura', recipe_type: recipe_type,
                         cuisine: 'Brasileira', difficulty: 'Medio',
                         cook_time: 60,
                         user:admin,
                         ingredients: 'Farinha, açucar, cenoura',
                         cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')
    visit root_path

    click_on 'Entrar'

    within('form')do
      fill_in 'Email', with:admin.email
      fill_in 'Senha', with:'123456'
      click_on 'Entrar'
    end

    click_on 'Receitas pendentes'

    expect(page).to have_css('h1', text:recipe.title)
    expect(page).to have_css('li', text:'Sobremesa')
    expect(page).to have_css('li', text:'Brasileira')
    expect(page).to have_css('li', text:'Medio')
    expect(page).to have_css('li', text:"60 minutos")

  end
  scenario ' and admin accepted recipe' do
    admin = User.create(email:'admin@email.com', password:'123456', admin:true)

    recipe_type = RecipeType.create(name: 'Sobremesa')
    recipe = Recipe.create(title: 'Bolo de cenoura', recipe_type: recipe_type,
                         cuisine: 'Brasileira', difficulty: 'Medio',
                         cook_time: 60,
                         user:admin,
                         ingredients: 'Farinha, açucar, cenoura',
                         cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')
    visit root_path


      click_on 'Entrar'


    within('form')do
      fill_in 'Email', with:admin.email
      fill_in 'Senha', with:'123456'
      click_on 'Entrar'
    end

    click_on 'Receitas pendentes'


    click_on 'Aceitar'


    expect(page).to have_content 'Receita aceita'
    expect(page).not_to have_content 'Bolo de cenoura'
  end

  scenario ' and admin reject pendent recipe' do
    admin = User.create(email:'admin@email.com', password:'123456', admin:true)

    recipe_type = RecipeType.create(name: 'Sobremesa')
    recipe = Recipe.create(title: 'Bolo de cenoura', recipe_type: recipe_type,
                         cuisine: 'Brasileira', difficulty: 'Medio',
                         cook_time: 60,
                         user:admin,
                         ingredients: 'Farinha, açucar, cenoura',
                         cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')
    visit root_path


      click_on 'Entrar'


    within('form')do
      fill_in 'Email', with:admin.email
      fill_in 'Senha', with:'123456'
      click_on 'Entrar'
    end

    click_on 'Receitas pendentes'

    click_on 'Rejeitar'

    expect(page).not_to have_css('h1', text:'Bolo de cenoura')
    expect(page).to have_content 'Receita rejeitada'
  end
end
