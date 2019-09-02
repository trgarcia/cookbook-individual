require 'rails_helper'

feature 'Authenticated user view your recipes' do

  scenario 'sucessifully' do
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name:'Brasileira')

    user = User.create(email: 'user@email.com', password:'123456')

    Recipe.create(title: 'Bolo de laranja', recipe_type: recipe_type,
                 cuisine: cuisine, difficulty: 'Medio',
                 cook_time: 60,
                 user:user,
                 ingredients: 'Farinha, açucar, cenoura',
                 cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')
   other = User.create(email:'other@email.com',password:'123465')
   Recipe.create(title: 'Bolo de cenoura', recipe_type: recipe_type,
                 cuisine: cuisine, difficulty: 'Medio',
                 cook_time: 60,
                 user:other,
                 ingredients: 'Farinha, açucar, cenoura',
                 cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')


    visit root_path

    click_on 'Entrar'

    within('form') do
      fill_in 'Email', with: user.email
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
    end


    click_on 'Minhas receitas'

    expect(page).to have_content 'Bolo de laranja'
    expect(page).not_to have_content 'Bolo de cenoura'


  end
  scenario 'and delete a of recipes' do
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name:'Brasileira')

    user = User.create(email: 'user@email.com', password:'123456')

    recipe = Recipe.create(title: 'Bolo de laranja', recipe_type: recipe_type,
                 cuisine: cuisine, difficulty: 'Medio',
                 cook_time: 60,
                 user:user,
                 ingredients: 'Farinha, açucar, cenoura',
                 cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')
    other = Recipe.create(title: 'Bolo de milho', recipe_type: recipe_type,
                cuisine: cuisine, difficulty: 'Medio',
                cook_time: 60,
                user:user,
                ingredients: 'Farinha, açucar, cenoura',
                cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')

   visit root_path

   click_on 'Entrar'

   within('form') do
     fill_in 'Email', with: user.email
     fill_in 'Senha', with: '123456'
     click_on 'Entrar'
   end


   click_on 'Minhas receitas'

   within("##{recipe.id}") do
     click_on 'Deletar'
   end

   expect(current_path).to eq user_recipes_path
   expect(page).to have_content 'Bolo de milho'
   expect(page).not_to have_content 'Bolo de laranja'
   expect(page).to have_content 'Receita apagada'

  end

end
