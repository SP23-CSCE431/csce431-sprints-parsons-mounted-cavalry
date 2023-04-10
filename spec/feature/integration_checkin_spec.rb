require 'rails_helper'

# testing check in functionality
RSpec.describe('Cadet checking in', type: :feature) do
    # sunny day
    before do
        User.create(is_admin: false, is_staff: false, first_name: 'John', last_name: 'Doe', classification: 'Senior', skill_level: 'Advanced', phone_number: '2025550136', email: 'tony@tamu.edu')
        Rails.application.env_config["devise.mapping"] = Devise.mappings[:admin]
        Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
        visit root_path
        click_on 'Sign in with Google'
    end

    scenario 'valid check in' do
        user = User.create(is_admin: false, is_staff: false, first_name: 'John', last_name: 'Doe', classification: 'Senior', skill_level: 'Advanced', phone_number: '2025550136', email: 'j.doe@tamu.edu')
        schedule = Schedule.create(user_id: user.id, recurrence: ['M', 'W', 'F'])
        horse = Horse.create(name: 'Ed', brand: 'B12', herd: 'Charlie', difficulty: 'Intermediate', condition: 'Healthy')
        Attendance.create(schedule_id: schedule.id, horse_id: horse.id, date: "10/04/2023", purpose: "Ride")
        
        visit 'pages/checkin_cadets'
        page.execute_script "navigator.geolocation.getCurrentPosition = function(success) { success({coords: {latitude: 30.61053102688138, longitude: -96.37446131426022}}); }"
        click_on 'Check In'

        expect(page).to(have_content('You have been checked in.'))
    end
end