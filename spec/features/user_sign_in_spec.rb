require 'rails_helper'

feature ' User sign_in ' do
  scenario ' Successfully' do
    user = User.create(email: 'user@email.com', password: '123456')

    visit root_path

    click_on 'Entrar'

    within("form") do
      fill_in 'Email', with: 'user@email.com'
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
    end

    expect(current_path).to eq root_path
    expect(page).to have_content 'Sair'
    expect(page).not_to have_content 'Entrar'

  end
end
