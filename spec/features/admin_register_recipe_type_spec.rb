require 'rails_helper'

feature 'Admin register recipe type ' do
  scenario 'Successfully' do
    visit root_path

    click_on 'Cadastrar tipo de receita'

    fill_in 'Nome', with: 'Sobremesa'
    click_on 'Enviar'

    expect(page).to have_css('h1', text:'Sobremesa')
  end
  scenario 'and must fill in field name' do
    visit root_path

    click_on 'Cadastrar tipo de receita'

    click_on 'Enviar'

    expect(page).to have_content('Voce deve preencher o campo nome')
  end
  scenario 'and name must be unique' do
    RecipeType.create(name: 'Sobremesa')

    visit root_path

    click_on 'Cadastrar tipo de receita'

    fill_in 'Nome', with: 'Sobremesa'
    
    click_on 'Enviar'

    expect(page).to have_content('Esse tipo de receita ja existe')

  end
end
