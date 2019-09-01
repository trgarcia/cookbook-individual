require 'rails_helper'

feature 'Admin register cuisine' do
  scenario 'Successfully' do
    admin = User.create(email:'admin@email.com', password:'123456', admin:true)

    visit root_path

    click_on 'Entrar'

    within('form') do
      fill_in 'Email', with: admin.email
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
    end

    click_on 'Cadastrar cozinha'

    fill_in 'Nome', with: 'Brasileira'
    click_on 'Enviar'

    expect(current_path).to eq root_path
    expect(page).to have_content 'Cozinha cadastrada com sucesso!'
  end
  scenario 'must be fill in all fields' do
    admin = User.create(email:'admin@email.com', password:'123456', admin:true)

    visit root_path

    click_on 'Entrar'

    within('form') do
      fill_in 'Email', with: admin.email
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
    end

    click_on 'Cadastrar cozinha'

    fill_in 'Nome', with: ''
    click_on 'Enviar'

    expect(current_path).to eq cuisines_path
    expect(page).to have_content 'Nome não pode ficar em branco'
  end
  scenario 'field name must be unique' do
    admin = User.create(email:'admin@email.com', password:'123456', admin:true)
    Cuisine.create(name:'Brasileira')
    visit root_path

    click_on 'Entrar'

    within('form') do
      fill_in 'Email', with: admin.email
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
    end

    click_on 'Cadastrar cozinha'

    fill_in 'Nome', with: 'Brasileira'
    click_on 'Enviar'

    expect(current_path).to eq cuisines_path
    expect(page).to have_content 'Nome já está em uso'
  end
  scenario 'just admin see button for register cuisine' do
    user = User.create(email:'admin@email.com', password:'123456')

    visit root_path

    click_on 'Entrar'

    within('form') do
      fill_in 'Email', with: user.email
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
    end


    expect(page).not_to have_link 'Cadastrar cozinha'
  end

  scenario 'just admin can register cuisine' do
    user = User.create(email:'admin@email.com', password:'123456')

    visit root_path

    click_on 'Entrar'

    within('form') do
      fill_in 'Email', with: user.email
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
    end

    visit new_cuisine_path

    expect(current_path).to eq root_path
  end
end
