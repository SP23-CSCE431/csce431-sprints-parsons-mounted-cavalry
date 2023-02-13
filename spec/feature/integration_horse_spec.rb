require 'rails_helper'

RSpec.describe 'Creating a horse', type: :feature do
  scenario 'valid inputs' do
    visit new_horse_path
    fill_in "horse[name]", with: "Horsey"
    fill_in "horse[brand]", with: 'H1199'
    fill_in "horse[birthday]", with: '01/01/1999'
    click_on 'Create Horse'
    expect(page).to have_content('Horsey was successfully created.')
  end
end
RSpec.describe 'Viewing a horse', type: :feature do
    scenario 'valid inputs' do
      horse = Horse.create(name: "Horsey", brand: 'H1199', birthday: '01/01/1999')
      visit horse_path(id: horse.id)
      expect(page).to have_content('Horsey')
      expect(page).to have_content('Brand')
      expect(page).to have_content('Birthday')
    end
  end
RSpec.describe 'Editing a horse', type: :feature do
    scenario 'valid inputs' do
      horse = Horse.create(name: "Horsey", brand: 'H1199', birthday: '01/01/1999')
      visit edit_horse_path(id: horse.id)
      fill_in "horse[name]", with: "Horsey1"
      fill_in "horse[brand]", with: 'H11991'
      fill_in "horse[birthday]", with: '01/02/1999'
      click_on 'Update Horse'
      expect(page).to have_content('Horsey1 was successfully updated.')
    end
  end
RSpec.describe 'Deleting a horse', type: :feature do
    scenario 'valid inputs' do
      horse = Horse.create(name: "Horsey1", brand: 'H1199', birthday: '01/01/1999')
      visit delete_horse_path(id: horse.id)
      click_on 'Delete Horse'
      expect(page).to have_content('Horsey1 was successfully destroyed.')
    end
  end