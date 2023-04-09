require 'rails_helper'

RSpec.describe('Login through Oauth', type: :feature) do
    describe 'admin login' do
        it 'valid inputs' do
            User.create(is_admin: true, is_staff: true, first_name: 'John', last_name: 'Doe', classification: 'Senior', skill_level: 'Advanced', phone_number: '2025550136', email: 'tony@tamu.edu')
            Rails.application.env_config["devise.mapping"] = Devise.mappings[:admin]
            Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
            visit root_path
            click_on 'Sign in with Google'
            expect(page).to(have_content('Successfully authenticated from Google account.'))
            expect(page).to(have_content('Admin'))
        end

        it 'invalid email type' do
            user = User.create(is_admin: true, is_staff: true, first_name: 'John', last_name: 'Doe', classification: 'Senior', skill_level: 'Advanced', phone_number: '2025550136', email: 'tony@gmail.com')
            expect(user).not_to be_valid
            Rails.application.env_config["devise.mapping"] = Devise.mappings[:admin]
            Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth3]
        end

        it 'invalid access' do
            visit admin_google_oauth2_omniauth_authorize_path
            expect(page).to(have_content('Not found. Authentication passthru.'))
        end
    end

    describe 'staff login' do
        it 'valid inputs' do
            User.create(is_admin: false, is_staff: true, first_name: 'John', last_name: 'Doe', classification: 'Senior', skill_level: 'Advanced', phone_number: '2025550136', email: 'tony@tamu.edu')
            Rails.application.env_config["devise.mapping"] = Devise.mappings[:admin]
            Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
            visit root_path
            click_on 'Sign in with Google'
            expect(page).to(have_content('Successfully authenticated from Google account.'))
            expect(page).to(have_content('Staff'))
        end

        it 'invalid email type' do
            user = User.create(is_admin: true, is_staff: true, first_name: 'John', last_name: 'Doe', classification: 'Senior', skill_level: 'Advanced', phone_number: '2025550136', email: 'tony@gmail.com')
            expect(user).not_to be_valid
            Rails.application.env_config["devise.mapping"] = Devise.mappings[:admin]
            Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth3]
        end

        it 'invalid access' do
            visit admin_google_oauth2_omniauth_authorize_path
            expect(page).to(have_content('Not found. Authentication passthru.'))
        end
    end

    describe 'cadet login' do
        it 'valid inputs' do
            User.create(is_admin: false, is_staff: false, first_name: 'John', last_name: 'Doe', classification: 'Senior', skill_level: 'Advanced', phone_number: '2025550136', email: 'tony@tamu.edu')
            Rails.application.env_config["devise.mapping"] = Devise.mappings[:admin]
            Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
            visit root_path
            click_on 'Sign in with Google'
            expect(page).to(have_content('Successfully authenticated from Google account.'))
            expect(page).to(have_content('Cadet'))
        end

        it 'invalid email type' do
            user = User.create(is_admin: false, is_staff: false, first_name: 'John', last_name: 'Doe', classification: 'Senior', skill_level: 'Advanced', phone_number: '2025550136', email: 'tony@gmail.com')
            expect(user).not_to be_valid
            Rails.application.env_config["devise.mapping"] = Devise.mappings[:admin]
            Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth3]
        end

        it 'invalid access' do
            visit admin_google_oauth2_omniauth_authorize_path
            expect(page).to(have_content('Not found. Authentication passthru.'))
        end
    end
end
