require 'rails_helper'

RSpec.describe 'Editing a cadet', type: :feature do
  scenario 'valid inputs' do
    visit edit_cadet_path
    fill_in 'cadet[first_name]', with: 'Billy2'
    fill_in 'cadet[last_name]', with: 'Bob2'
    fill_in 'cadet[graduation_year]', with: '2025'
    fill_in 'cadet[phone_number]', with: '9876543210'
    fill_in 'cadet[uin]', with: '654300021'
    click_on 'Update Cadet'
    
    expect(page).to have_content('Cadet was successfully updated.')
    expect(Cadet.last.uin).to eq('120003456')
  end


end