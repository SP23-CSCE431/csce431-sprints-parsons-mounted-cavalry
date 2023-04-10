require 'rails_helper'

# testing creation of attendance
RSpec.describe('Creating an attendance', type: :feature) do
    # sunny day
    before do
        User.create(is_admin: true, is_staff: true, first_name: 'John', last_name: 'Doe', classification: 'Senior', skill_level: 'Advanced', phone_number: '2025550136', email: 'tony@tamu.edu')
        Rails.application.env_config["devise.mapping"] = Devise.mappings[:admin]
        Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
        visit root_path
        click_on 'Sign in with Google'
    end

    scenario 'valid inputs' do
        user = User.create(is_admin: true, is_staff: true, first_name: 'John', last_name: 'Doe', classification: 'Senior', skill_level: 'Advanced', phone_number: '2025550136', email: 'j.doe@tamu.edu')
        Schedule.create(user_id: user.id, recurrence: ['M', 'W', 'F'])
        Horse.create(name: 'Ed', brand: 'B12', herd: 'Charlie', difficulty: 'Intermediate', condition: 'Healthy')
        
        visit 'schedules/admins'
        cells = page.all("tr##{user.id} td > a")
        cells[0].click
        date = Date.today.beginning_of_week

        expect(page).to(have_content('John Doe'))
        expect(page).to(have_content(date.strftime('%A, %B %-d, %Y')))
        find_by_id('attendance_horse_id').find(:xpath, 'option[2]').select_option
        select 'Training', from: 'attendance[purpose]'
        click_on 'Create Attendance'
        expect(page).to(have_content('Attendance was successfully created.'))
    end
end

# testing view of attendance
RSpec.describe('Viewing an attendance', type: :feature) do
    before do
        User.create(is_admin: true, is_staff: true, first_name: 'John', last_name: 'Doe', classification: 'Senior', skill_level: 'Advanced', phone_number: '2025550136', email: 'tony@tamu.edu')
        Rails.application.env_config["devise.mapping"] = Devise.mappings[:admin]
        Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
        visit root_path
        click_on 'Sign in with Google'
    end

    scenario 'valid inputs' do
        user = User.create(is_admin: true, is_staff: true, first_name: 'John', last_name: 'Doe', classification: 'Senior', skill_level: 'Advanced', phone_number: '2025550136', email: 'j.doe@tamu.edu')
        schedule = Schedule.create(user_id: user.id, recurrence: ['M', 'W', 'F'])
        monday = Date.today.beginning_of_week
        Attendance.create(schedule_id: schedule.id, date: monday.strftime, check_in_time: nil, purpose: 'Training')

        visit 'schedules/admins'
        css = "tr##{user.id} td.attendance a"
        find(css).click

        expect(page).to(have_content('John Doe'))
        expect(page).to(have_content('None'))
        expect(page).to(have_content(monday.strftime))
        expect(page).to(have_content('Not checked in'))
        expect(page).to(have_content('Training'))
    end
end

# testing authorization for attendance
RSpec.describe('authorization for attendance', type: :feature) do
    describe 'cadet viewing' do
        before do
            User.create(is_admin: false, is_staff: false, first_name: 'John', last_name: 'Doe', classification: 'Senior', skill_level: 'Advanced', phone_number: '2025550136', email: 'tony@tamu.edu')
            Rails.application.env_config["devise.mapping"] = Devise.mappings[:admin]
            Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
            visit root_path
            click_on 'Sign in with Google'
        end

        scenario 'staff attendance' do
            visit staffs_attendances_path
            expect(page).to(have_content('You are not authorized to perform this action.'))
        end

        scenario 'admin attendance' do
            visit admins_attendances_path
            expect(page).to(have_content('You are not authorized to perform this action.'))
        end
    end

    describe 'staff viewing' do
        before do
            User.create(is_admin: false, is_staff: true, first_name: 'John', last_name: 'Doe', classification: 'Senior', skill_level: 'Advanced', phone_number: '2025550136', email: 'tony@tamu.edu')
            Rails.application.env_config["devise.mapping"] = Devise.mappings[:admin]
            Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
            visit root_path
            click_on 'Sign in with Google'
        end

        scenario 'admin attendance' do
            visit admins_attendances_path
            expect(page).to(have_content('You are not authorized to perform this action.'))
        end
    end
end

# testing updating of attendance
RSpec.describe('Updating an attendance', type: :feature) do
    before do
        User.create(is_admin: true, is_staff: true, first_name: 'John', last_name: 'Doe', classification: 'Senior', skill_level: 'Advanced', phone_number: '2025550136', email: 'tony@tamu.edu')
        Rails.application.env_config["devise.mapping"] = Devise.mappings[:admin]
        Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
        visit root_path
        click_on 'Sign in with Google'
    end

    scenario 'valid inputs' do
        user = User.create(is_admin: true, is_staff: true, first_name: 'John', last_name: 'Doe', classification: 'Senior', skill_level: 'Advanced', phone_number: '2025550136', email: 'j.doe@tamu.edu')
        schedule = Schedule.create(user_id: user.id, recurrence: ['M', 'W', 'F'])
        attendance = Attendance.create(schedule_id: schedule.id, date: '2023-03-15', check_in_time: nil, purpose: 'Training')
        horse = Horse.create(name: 'Ed', brand: 'B12', herd: 'Charlie', difficulty: 'Intermediate', condition: 'Healthy')

        visit edit_attendance_path(id: attendance.id)
        find(:xpath, "//*[@id='attendance_horse_id']/option[@value='#{horse.id}']").select_option
        select 'Ride & Work', from: 'attendance[purpose]'
        click_on 'Update Attendance'
        expect(page).to(have_content('Attendance was successfully updated.'))
    end
end

# testing deletion of attendance
RSpec.describe('Deleting an attendance', type: :feature) do
    before do
        User.create(is_admin: true, is_staff: true, first_name: 'John', last_name: 'Doe', classification: 'Senior', skill_level: 'Advanced', phone_number: '2025550136', email: 'tony@tamu.edu')
        Rails.application.env_config["devise.mapping"] = Devise.mappings[:admin]
        Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
        visit root_path
        click_on 'Sign in with Google'
    end

    scenario 'valid inputs' do
        user = User.create(is_admin: true, is_staff: true, first_name: 'John', last_name: 'Doe', classification: 'Senior', skill_level: 'Advanced', phone_number: '2025550136', email: 'j.doe@tamu.edu')
        schedule = Schedule.create(user_id: user.id, recurrence: ['M', 'W', 'F'])
        attendance = Attendance.create(schedule_id: schedule.id, date: '2023-12-25', check_in_time: nil, purpose: 'Training')

        visit 'schedules/admins'
        visit delete_attendance_path(id: attendance.id)
        click_on 'Delete'
        expect(page).to(have_content('Attendance was successfully deleted.'))
    end

    # if an attendance belongs to a schedule, then when that schedule is deleted
    # the attendance must be deleted as well
    scenario 'schedule that has attendance is deleted' do
        user = User.create(is_admin: true, is_staff: true, first_name: 'Jane', last_name: 'Doe', classification: 'Senior', skill_level: 'Advanced', phone_number: '2025550136', email: 'j.doe@tamu.edu')
        schedule = Schedule.create(user_id: user.id, recurrence: ['M', 'W', 'F'])
        attendance = Attendance.create(schedule_id: schedule.id, date: '2023-12-25', check_in_time: nil, purpose: 'Training')
        
        visit attendance_path(id: attendance.id)
        expect(page).to(have_content('Jane Doe'))
        schedule.destroy
        expect { visit(attendance_path(id: attendance.id)) }
            .to(raise_error(ActiveRecord::RecordNotFound))        
    end

    # if an attendance belongs to a user, then when that user is deleted
    # the attendance must be deleted as well
    scenario 'user that has attendance is deleted' do
        user = User.create(is_admin: true, is_staff: true, first_name: 'Jane', last_name: 'Doe', classification: 'Senior', skill_level: 'Advanced', phone_number: '2025550136', email: 'j.doe@tamu.edu')
        schedule = Schedule.create(user_id: user.id, recurrence: ['M', 'W', 'F'])
        attendance = Attendance.create(schedule_id: schedule.id, date: '2023-12-25', check_in_time: nil, purpose: 'Training')
        
        visit attendance_path(id: attendance.id)
        expect(page).to(have_content('Jane Doe'))
        user.destroy
        expect { visit(attendance_path(id: attendance.id)) }
            .to(raise_error(ActiveRecord::RecordNotFound))        
    end
end
