require 'rails_helper'

RSpec.describe 'Login through Oauth', type: :feature do
    setup do
        OmniAuth.config.test_mode = true
        OmniAuth.config.add_mock(:admin, uid: "12345", info: {email: "twitter@example.com"}, credentials: {token: 1})
    end
    scenario 'valid inputs' do
        visit root_path
        expect(page).to have_content('Sign in with Google')
    end

    scenario 'invalid email type' do
        visit new_admin_session_path
        expect(page).not_to have_content('Cadet was successfully created.')
    end
    scenario 'invalid access' do
        visit admin_google_oauth2_omniauth_authorize_path
        expect(page).to have_content('Not found. Authentication passthru.')
    end
end