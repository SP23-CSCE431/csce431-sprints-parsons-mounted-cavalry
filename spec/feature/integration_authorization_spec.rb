require 'rails_helper'

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

        it 'staff attendance' do
            visit staffs_attendances_path
            expect(page).to(have_content('You are not authorized to perform this action.'))
        end

        it 'admin attendance' do
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

        it 'admin attendance' do
            visit admins_attendances_path
            expect(page).to(have_content('You are not authorized to perform this action.'))
        end
    end
end

# authorization test for horses
RSpec.describe('authorization for horses', type: :feature) do
    describe 'cadet viewing' do
        before do
            User.create(is_admin: false, is_staff: false, first_name: 'John', last_name: 'Doe', classification: 'Senior', skill_level: 'Advanced', phone_number: '2025550136', email: 'tony@tamu.edu')
            Rails.application.env_config["devise.mapping"] = Devise.mappings[:admin]
            Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
            visit root_path
            click_on 'Sign in with Google'
        end

        it 'staff horses' do
            visit staffs_horses_path
            expect(page).to(have_content('You are not authorized to perform this action.'))
        end

        it 'admin horses' do
            visit admins_horses_path
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

        it 'admin horses' do
            visit admins_horses_path
            expect(page).to(have_content('You are not authorized to perform this action.'))
        end
    end
end

# authorization test for schedules
RSpec.describe('authorization for schedules', type: :feature) do
    describe 'cadet viewing' do
        before do
            User.create(is_admin: false, is_staff: false, first_name: 'John', last_name: 'Doe', classification: 'Senior', skill_level: 'Advanced', phone_number: '2025550136', email: 'tony@tamu.edu')
            Rails.application.env_config["devise.mapping"] = Devise.mappings[:admin]
            Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
            visit root_path
            click_on 'Sign in with Google'
        end

        it 'staff schedules' do
            visit staffs_schedules_path
            expect(page).to(have_content('You are not authorized to perform this action.'))
        end

        it 'admin schedules' do
            visit admins_schedules_path
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

        it 'admin schedules' do
            visit admins_horses_path
            expect(page).to(have_content('You are not authorized to perform this action.'))
        end
    end
end

# authorization test for schedules
RSpec.describe('authorization for user pages', type: :feature) do
    describe 'cadet viewing' do
        before do
            User.create(is_admin: false, is_staff: false, first_name: 'John', last_name: 'Doe', classification: 'Senior', skill_level: 'Advanced', phone_number: '2025550136', email: 'tony@tamu.edu')
            Rails.application.env_config["devise.mapping"] = Devise.mappings[:admin]
            Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
            visit root_path
            click_on 'Sign in with Google'
        end

        it 'staff users page' do
            visit staffs_users_path
            expect(page).to(have_content('You are not authorized to perform this action.'))
        end

        it 'admin users page' do
            visit admins_users_path
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

        it 'admin users' do
            visit admins_horses_path
            expect(page).to(have_content('You are not authorized to perform this action.'))
        end
    end
end
