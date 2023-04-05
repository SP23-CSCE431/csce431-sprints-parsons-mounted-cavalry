require 'rails_helper'

RSpec.describe('Login through Oauth', type: :feature) do
    before do
        User.create(is_admin: true, is_staff: true, first_name: 'John', last_name: 'Doe', classification: 'Senior', skill_level: 'Advanced', phone_number: '2025550136', email: 'tony@tamu.edu')
        Rails.application.env_config["devise.mapping"] = Devise.mappings[:admin]
        Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
    end

    it 'valid inputs' do
        visit root_path
        click_on 'Sign in with Google'
        expect(page).to(have_content('Successfully authenticated from Google account.'))
    end

    it 'invalid email type' do
        visit new_admin_session_path
        expect(page).not_to(have_content('Cadet was successfully created.'))
    end

    it 'invalid access' do
        visit admin_google_oauth2_omniauth_authorize_path
        expect(page).to(have_content('Not found. Authentication passthru.'))
    end
end
