require 'rails_helper'

# testing view of schedule
RSpec.describe 'Viewing an attendance', type: :feature do
    before(:each) do
        Rails.application.env_config["devise.mapping"] = Devise.mappings[:admin]
        Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
        visit root_path
        click_on 'Sign in with Google'
    end
    scenario 'days are highlighted for recurrence' do
        user = User.create(is_admin: true, is_staff: true, first_name: 'John', last_name: 'Doe', classification: 'Senior', skill_level: 'Advanced', phone_number: '2025550136', email: 'j.doe@tamu.edu')
        schedule = Schedule.create(user_id: user.id, recurrence: 'MWF')

        visit 'schedules/admins'
        css = 'tr#' + user.id.to_s + " td.recur"
        cells = page.all(css)
        expect(cells.size).to eq(3)
    end

    scenario 'content information display' do
        user = User.create(is_admin: true, is_staff: true, first_name: 'John', last_name: 'Doe', classification: 'Senior', skill_level: 'Advanced', phone_number: '2025550136', email: 'j.doe@tamu.edu')
        schedule = Schedule.create(user_id: user.id, recurrence: 'MWF')
        attendance = Attendance.create(schedule_id: schedule.id, date: '2023-03-15', check_in_time: nil, purpose: 'Training')

        visit 'schedules/admins'
        css = 'tr#' + user.id.to_s + " td.attendance"
        td = find(css).text

        expect(td).to have_content('Horse: None')
        expect(td).to have_content('Event: Training')
    end
end
