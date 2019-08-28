require 'rails_helper'

feature ' User edit a recipe' do
  scenario ' Successfully' do
    recipe_type = RecipeType.create(name: 'Sobremesa')
    user = User.create(email:'user@email.com', password:'123456')
    recipe = Recipe.create(status:1, title: 'Bolo de cenoura', recipe_type: recipe_type,
                           cuisine: 'Brasileira', difficulty: 'Medio',
                           cook_time: 60,
                           user: user,
                           ingredients: 'Farinha, açucar, cenoura',
                           cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')

    visit root_path

    click_on 'Entrar'

    within('form') do
      fill_in 'Email', with: user.email
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
    end

    click_on recipe.title
    click_on 'Editar'


    fill_in 'Titulo', with: 'Bolo de laranja'
    select 'Sobremesa', from: 'Tipo de receita'
    fill_in 'Cozinha', with: 'Brasileira'
    fill_in 'Dificuldade', with: 'Medio'
    fill_in 'Tempo de preparo', with: 60
    fill_in 'Ingredientes', with: 'Laranja, massa'
    fill_in 'Metodo de preparo', with: 'Asse'

    click_on 'Enviar'

    expect(page).to have_css('h1', text:'Bolo de laranja')
    expect(page).to have_css('p', text:'Sobremesa')
    expect(page).to have_css('p', text:'Brasileira')
    expect(page).to have_css('p', text:'Medio')
    expect(page).to have_css('p', text:"60 minutos")
    expect(page).to have_css('p', text:'Laranja, massa')
    expect(page).to have_css('p', text:'Asse')

  end

  scenario 'and must to be signed in for edit recipe' do
    recipe_type = RecipeType.create(name: 'Sobremesa')
    user = User.create(email:'user@email.com', password:'123456')
    recipe = Recipe.create(title: 'Bolo de cenoura', recipe_type: recipe_type,
                           cuisine: 'Brasileira', difficulty: 'Medio',
                           cook_time: 60,
                           user: user,
                           ingredients: 'Farinha, açucar, cenoura',
                           cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')

    visit edit_recipe_path(recipe)

    expect(current_path).to eq new_user_session_path

  end

  scenario 'just view button edit if is owner of recipe' do
    recipe_type = RecipeType.create(name: 'Sobremesa')
    user = User.create(email:'user@email.com', password:'123456')
    recipe = Recipe.create(status: 1 , title: 'Bolo de cenoura', recipe_type: recipe_type,
                           cuisine: 'Brasileira', difficulty: 'Medio',
                           cook_time: 60,
                           user: user,
                           ingredients: 'Farinha, açucar, cenoura',
                           cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')

    other = User.create(email:'other@email.com', password:'123456')
    visit root_path

    click_on 'Entrar'

    within('form') do
      fill_in 'Email', with:other.email
      fill_in 'Senha', with:'123456'
      click_on 'Entrar'
    end



    click_on recipe.title

    expect(page).not_to have_link 'Editar'
  end
end
