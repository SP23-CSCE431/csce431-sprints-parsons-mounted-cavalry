require 'rails_helper'

RSpec.describe 'Creating a horse', type: :feature do
    scenario 'valid inputs' do
        visit new_horse_path
        fill_in "horse[name]", with: "Horsey"
        fill_in "horse[brand]", with: 'H1199'
        select "Alpha", :from => "horse[herd]"
        select "Easy", :from => "horse[difficulty]"
        fill_in "horse[condition]", with: 'Healthy'
        click_on 'Create Horse'
        expect(page).to have_content('Horsey was successfully created.')
    end
    scenario 'nonunique brand' do
        horse = Horse.create(name: 'Horsey', brand: 'H1199',  herd: 'Alpha', difficulty: 'Easy', condition: 'Healthy')
        visit new_horse_path
        fill_in "horse[name]", with: "Horsey"
        fill_in "horse[brand]", with: 'H1199'
        select "Alpha", :from => "horse[herd]"
        select "Easy", :from => "horse[difficulty]"
        fill_in "horse[condition]", with: 'Healthy'
        click_on 'Create Horse'
        expect(page).to have_content('Brand has already been taken')
    end
end

RSpec.describe 'Viewing a horse', type: :feature do
        scenario 'valid inputs' do
        horse = Horse.create(name: 'Horsey', brand: 'H1199',  herd: 'Alpha', difficulty: 'Easy', condition: 'Healthy')
        visit horse_path(id: horse.id)
        expect(page).to have_content('Horsey')
        expect(page).to have_content('H1199')
        expect(page).to have_content('Easy')
        expect(page).to have_content('Alpha')
        expect(page).to have_content('Healthy')
        end
end

RSpec.describe 'Editing a horse', type: :feature do
    scenario 'valid inputs' do
        horse = Horse.create(name: 'Horsey', brand: 'H1199',  herd: 'Alpha', difficulty: 'Easy', condition: 'Healthy')
        visit edit_horse_path(id: horse.id)
        fill_in "horse[name]", with: "Horsey1"
        fill_in "horse[brand]", with: 'H11991'
        select "Charlie", :from => "horse[herd]"
        select "Intermediate", :from => "horse[difficulty]"
        fill_in "horse[condition]", with: 'Injured'
        click_on 'Update Horse'
        expect(page).to have_content('Horsey1 was successfully updated.')
    end
    scenario 'updating brand with already existing one' do
        horse = Horse.create(name: 'Horsey', brand: 'H1199',  herd: 'Alpha', difficulty: 'Easy', condition: 'Healthy')
        horse1 = Horse.create(name: 'Hor', brand: 'H1198',  herd: 'Bravo', difficulty: 'Easy', condition: 'Healthy')
        visit edit_horse_path(id: horse1.id)
        fill_in "horse[name]", with: "Horsey1"
        fill_in "horse[brand]", with: 'H1199'
        select "Charlie", :from => "horse[herd]"
        select "Intermediate", :from => "horse[difficulty]"
        fill_in "horse[condition]", with: 'Injured'
        click_on 'Update Horse'
        expect(page).to have_content('Brand has already been taken')
    end 
end

RSpec.describe 'Deleting a horse', type: :feature do
    scenario 'valid inputs' do
        horse = Horse.create(name: 'Horsey1', brand: 'H1199',  herd: 'Alpha', difficulty: 'Easy', condition: 'Healthy')
        visit delete_horse_path(id: horse.id)
        click_on 'Delete Horse'
        expect(page).to have_content('Horsey1 was successfully destroyed.')
    end
end
