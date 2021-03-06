require 'rails_helper'

feature 'User register recipe' do
  scenario 'sucessifully' do

    recipe_type = RecipeType.create(name: 'Sobremesa')
    Cuisine.create(name:'Brasileira')

    user = User.create(email: 'user@email.com', password:'123456')

    visit root_path

    click_on 'Entrar'

    within('form') do
      fill_in 'Email', with: user.email
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
    end

    click_on 'Cadastrar Receita'



    fill_in 'Titulo', with: 'Bolo de laranja'
    select 'Sobremesa', from: 'Tipo de receita'
    select 'Brasileira', from: 'Cozinha'
    fill_in 'Dificuldade', with: 'Medio'
    fill_in 'Tempo de preparo', with: 60
    fill_in 'Ingredientes', with: 'Laranja, massa'
    fill_in 'Metodo de preparo', with: 'Asse'

    click_on 'Enviar'

    visit root_path

    expect(page).not_to have_css('h1', text:'Bolo de laranja')

  end

  scenario 'and must fill in all fields ' do
    recipe_type = RecipeType.create(name: 'Sobremesa')
    user = User.create(email: 'user@email.com', password:'123456')
    Cuisine.create(name:'Brasileira')

    visit root_path

    click_on 'Entrar'

    within('form') do
      fill_in 'Email', with: user.email
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
    end

    click_on 'Cadastrar Receita'

    fill_in 'Titulo', with: 'Bolo de laranja'
    select 'Sobremesa', from: 'Tipo de receita'
    select 'Brasileira', from: 'Cozinha'
    fill_in 'Dificuldade', with: ''
    fill_in 'Tempo de preparo', with: 60
    fill_in 'Ingredientes', with: 'Laranja, massa'
    fill_in 'Metodo de preparo', with: 'Asse'

    click_on 'Enviar'


    expect(page).to have_content('Voce deve preencher todos os campos')

  end

  scenario ' user must to be authenticated for create recipe' do
      visit new_recipe_path

      expect(current_path).to eq new_user_session_path
  end

  scenario ' Ao cadastrar receita deve ficar vinculada com o usuario' do
    recipe_type = RecipeType.create(name: 'Sobremesa')
    user = User.create(email: 'user@email.com', password:'123456')
    Cuisine.create(name:'Brasileira')

    visit root_path

    click_on 'Entrar'

    within('form') do
      fill_in 'Email', with: user.email
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
    end

    click_on 'Cadastrar Receita'



    fill_in 'Titulo', with: 'Bolo de laranja'
    select 'Sobremesa', from: 'Tipo de receita'
    select 'Brasileira', from: 'Cozinha'
    fill_in 'Dificuldade', with: 'Medio'
    fill_in 'Tempo de preparo', with: 60
    fill_in 'Ingredientes', with: 'Laranja, massa'
    fill_in 'Metodo de preparo', with: 'Asse'

    click_on 'Enviar'

    expect(page).to have_content 'Receita enviada por user@email.com'
  end



end
