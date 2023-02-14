require 'rails_helper'

RSpec.describe 'Creating a cadet', type: :feature do
  scenario 'valid inputs' do
    visit new_cadet_path
    fill_in 'cadet[first_name]', with: 'Billy'
    fill_in 'cadet[last_name]', with: 'Bob'
    fill_in 'cadet[graduation_year]', with: '2024'
    fill_in 'cadet[phone_number]', with: '0123456789'
    fill_in 'cadet[uin]', with: '120003456'
    click_on 'Create Cadet'
    
    expect(page).to have_content('Cadet was successfully created.')
    expect(Cadet.last.uin).to eq('120003456')
  end

  scenario 'missing first_name' do
    visit new_cadet_path
    fill_in 'cadet[last_name]', with: 'Bob'
    fill_in 'cadet[graduation_year]', with: '2024'
    fill_in 'cadet[phone_number]', with: '0123456789'
    fill_in 'cadet[uin]', with: '120003456'
    click_on 'Create Cadet'
    
    expect(page).not_to have_content('Cadet was successfully created.')
  end

  scenario 'missing last_name' do
    visit new_cadet_path
    fill_in 'cadet[first_name]', with: 'Billy'
    fill_in 'cadet[graduation_year]', with: '2024'
    fill_in 'cadet[phone_number]', with: '0123456789'
    fill_in 'cadet[uin]', with: '120003456'
    click_on 'Create Cadet'
    
    expect(page).not_to have_content('Cadet was successfully created.')
  end

  scenario 'missing graduation_year' do
    visit new_cadet_path
    fill_in 'cadet[first_name]', with: 'Billy'
    fill_in 'cadet[last_name]', with: 'Bob'
    fill_in 'cadet[phone_number]', with: '0123456789'
    fill_in 'cadet[uin]', with: '120003456'
    click_on 'Create Cadet'
    
    expect(page).not_to have_content('Cadet was successfully created.')
  end

  scenario 'missing phone_number' do
    visit new_cadet_path
    fill_in 'cadet[first_name]', with: 'Billy'
    fill_in 'cadet[last_name]', with: 'Bob'
    fill_in 'cadet[graduation_year]', with: '2024'
    fill_in 'cadet[uin]', with: '120003456'
    click_on 'Create Cadet'
    
    expect(page).not_to have_content('Cadet was successfully created.')
  end

  scenario 'missing uin' do
    visit new_cadet_path
    fill_in 'cadet[first_name]', with: 'Billy'
    fill_in 'cadet[last_name]', with: 'Bob'
    fill_in 'cadet[graduation_year]', with: '2024'
    fill_in 'cadet[phone_number]', with: '0123456789'
    
    expect(page).not_to have_content('Cadet was successfully created.')
  end

end