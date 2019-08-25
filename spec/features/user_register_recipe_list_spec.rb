require 'rails_helper'

feature 'User register recipe list' do
  scenario 'Successfully' do
    user = User.create(email:'user@email.com', password:'123456')

    visit root_path

    click_on 'Entrar'

    within('form')do
      fill_in 'Email', with:user.email
      fill_in 'Senha', with:'123456'
      click_on 'Entrar'
    end

    click_on 'Criar lista de receitas'

    fill_in 'Nome', with: 'Churras'
    click_on 'Criar'

    expect(current_path).to eq root_path
    expect(page).to have_content 'Lista criada com sucesso'
  end

  scenario 'user view your recipe lists' do
    user = User.create(email:'user@email.com', password:'123456')
    RecipeList.create(name:'Churras',user:user)

    visit root_path

    click_on 'Entrar'

    within('form')do
      fill_in 'Email', with:user.email
      fill_in 'Senha', with:'123456'
      click_on 'Entrar'
    end

    click_on 'Minhas listas de receitas'

    expect(page).to have_css('h1', text:'Churras')
  end

  scenario 'and name of lists cant to be duplicate ' do
    user = User.create(email:'user@email.com', password:'123456')
    RecipeList.create(name:'Churras',user:user)

    visit root_path

    click_on 'Entrar'

    within('form')do
      fill_in 'Email', with:user.email
      fill_in 'Senha', with:'123456'
      click_on 'Entrar'
    end

    click_on 'Criar lista de receitas'

    fill_in 'Nome', with: 'Churras'
    click_on 'Criar'

    #expect(current_path).to eq recipe_list_path
    expect(page).to have_content 'Falha ao criar lista'
  end
end
