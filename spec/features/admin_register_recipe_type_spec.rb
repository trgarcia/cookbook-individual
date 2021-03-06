require 'rails_helper'

feature 'Admin register recipe type ' do
  scenario 'Successfully' do
    admin = User.create(email:'admin@email.com', password:'123456', admin:true)

    visit root_path

    click_on 'Entrar'

    within('form') do
      fill_in 'Email', with: admin.email
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
    end

    click_on 'Cadastrar tipo de receita'

    fill_in 'Nome', with: 'Sobremesa'
    click_on 'Enviar'

    expect(page).to have_css('h1', text:'Sobremesa')
  end
  scenario 'and must fill in field name' do
    admin = User.create(email:'admin@email.com', password:'123456', admin:true)

    visit root_path

    click_on 'Entrar'

    within('form') do
      fill_in 'Email', with: admin.email
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
    end

    click_on 'Cadastrar tipo de receita'

    click_on 'Enviar'

    expect(page).to have_content('Voce deve preencher o campo nome')
  end
  scenario 'and name must be unique' do
    RecipeType.create(name: 'Sobremesa')


    admin = User.create(email:'admin@email.com', password:'123456', admin:true)

    visit root_path

    click_on 'Entrar'

    within('form') do
      fill_in 'Email', with: admin.email
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
    end

    click_on 'Cadastrar tipo de receita'

    fill_in 'Nome', with: 'Sobremesa'

    click_on 'Enviar'

    expect(page).to have_content('Esse tipo de receita ja existe')

  end

  scenario 'just admin see button of register recipe type' do
    user = User.create(email:'user@email.com',password:'123456')

    visit root_path

    click_on 'Entrar'

    within('form') do
      fill_in 'Email', with: user.email
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
    end

    expect(page).not_to have_link 'Cadastrar tipo de receita'
  end

  scenario 'just admin can register recipe type' do
    user = User.create(email:'user@email.com',password:'123456')

    visit root_path

    click_on 'Entrar'

    within('form') do
      fill_in 'Email', with: user.email
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
    end

    visit new_recipe_type_path

    expect(current_path).to eq root_path
  end
end
