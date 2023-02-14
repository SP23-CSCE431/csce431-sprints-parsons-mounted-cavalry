require 'rails_helper'

RSpec.describe 'Creating a staff member', type: :feature do
    scenario 'valid inputs' do
        visit new_staff_path

        find("label[for='staff_is_admin']").click
        fill_in 'staff[first_name]', with: 'John'
        fill_in 'staff[last_name]', with: 'Doe'
        fill_in 'staff[phone_number]', with: '123-456-7890'
        fill_in 'staff[email]', with: 'jdoe@tamu.edu'
        fill_in 'staff[password]', with: 'jdoe123.'

        click_on 'Create Staff'

        expect(page).to have_content('Staff was successfully created.')
  end
end

RSpec.describe 'Viewing a staff member', type: :feature do
    scenario 'valid inputs' do
        staff = Staff.create(
            is_admin: false,
            first_name: 'John',
            last_name: 'Doe',
            phone_number: '123-456-7890',
            email: 'john.doe@tamu.edu',
            password: 'jdoe123.'
        )

        visit staff_path(id: staff.id)

        expect(page).to have_content('John')
        expect(page).to have_content('Doe')
        expect(page).to have_content('123-456-7890')
        expect(page).to have_content('john.doe@tamu.edu')
        expect(page).to have_content('jdoe123.')
    end
end

RSpec.describe 'Editing a staff member', type: :feature do
    scenario 'valid inputs' do
        staff = Staff.create(
            is_admin: false,
            first_name: 'John',
            last_name: 'Doe',
            phone_number: '123-456-7890',
            email: 'john.doe@tamu.edu',
            password: 'jdoe123.'
        )

        visit edit_staff_path(id: staff.id)

        find("label[for='staff_is_admin']").click
        fill_in 'staff[first_name]', with: 'Jane'
        fill_in 'staff[last_name]', with: 'Deer'
        fill_in 'staff[phone_number]', with: '987-654-3210'
        fill_in 'staff[email]', with: 'jdeer@tamu.edu'
        fill_in 'staff[password]', with: 'jdeer321!'

        click_on 'Update Staff'
        expect(page).to have_content('Staff was successfully updated.')
    end
end

RSpec.describe 'Deleting a horse', type: :feature do
    scenario 'valid inputs' do
        staff = Staff.create(
            is_admin: false,
            first_name: 'John',
            last_name: 'Doe',
            phone_number: '123-456-7890',
            email: 'john.doe@tamu.edu',
            password: 'jdoe123.'
        )

        visit delete_staff_path(id: staff.id)
        click_on 'Delete Staff'
        expect(page).to have_content('Staff was successfully destroyed.')
    end
end 

