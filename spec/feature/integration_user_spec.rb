require 'rails_helper'

RSpec.describe 'Creating a user', type: :feature do
    scenario 'valid inputs' do
        visit new_user_path
        fill_in "user[first_name]", with: "Billy"
        fill_in "user[last_name]", with: 'Bob'
        select "Junior", :from => "user[classification]"
        select "Intermediate", :from => "user[skill_level]"
        fill_in "user[phone_number]", with: '123-456-7890'
        fill_in "user[email]", with: 'billybob@tamu.edu'
        click_on 'Create User'
        expect(page).to have_content('Billy Bob was successfully created.')
    end
end

RSpec.describe 'Viewing a user', type: :feature do
        scenario 'valid inputs' do
            user = User.create(first_name: 'Billy', last_name: 'Bob', classification: 'Junior',  skill_level: 'Intermediate', phone_number: '123-456-7890', email: 'billybob@tamu.edu', is_staff: 'false', is_admin: 'false')
            visit user_path(id: user.id)
            expect(page).to have_content('Billy')
            expect(page).to have_content('Bob')
            expect(page).to have_content('Junior')
            expect(page).to have_content('Intermediate')
            expect(page).to have_content('123-456-7890')
            expect(page).to have_content('billybob@tamu.edu')
        end
end

RSpec.describe 'Editing a user', type: :feature do
    scenario 'valid inputs' do
        user = User.create(first_name: 'Billy', last_name: 'Bob', classification: 'Junior',  skill_level: 'Intermediate', phone_number: '123-456-7890', email: 'billybob@tamu.edu', is_staff: 'false', is_admin: 'false')
        visit edit_user_path(id: user.id)
        fill_in "user[first_name]", with: "Billy1"
        fill_in "user[last_name]", with: 'Bob1'
        select "Senior", :from => "user[classification]"
        select "Advanced", :from => "user[skill_level]"
        fill_in "user[phone_number]", with: '123-456-7899'
        fill_in "user[email]", with: 'billybob1@tamu.edu'
        click_on 'Update User'
        expect(page).to have_content('Billy1 Bob1 was successfully updated.')
    end
end

RSpec.describe 'Deleting a user', type: :feature do
    scenario 'valid inputs' do
        user = User.create(first_name: 'Billy', last_name: 'Bob', classification: 'Junior',  skill_level: 'Intermediate', phone_number: '123-456-7890', email: 'billybob@tamu.edu', is_staff: 'false', is_admin: 'false')
        visit delete_user_path(id: user.id)
        click_on 'Delete User'
        expect(page).to have_content('Billy Bob was successfully destroyed.')
    end
end