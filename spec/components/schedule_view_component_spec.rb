# frozen_string_literal: true

require "rails_helper"

RSpec.describe ScheduleViewComponent, type: :component do
    before do
        User.create(is_admin: true, is_staff: true, first_name: 'John', last_name: 'Doe', classification: 'Senior', skill_level: 'Advanced', phone_number: '2025550136', email: 'tony@tamu.edu')
        Rails.application.env_config["devise.mapping"] = Devise.mappings[:admin]
        Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
        visit root_path
        click_on 'Sign in with Google'
    end

    scenario 'days are highlighted for recurrence' do
        user = User.create!(is_admin: true, is_staff: true, first_name: 'John', last_name: 'Doe', classification: 'Senior', skill_level: 'Advanced', phone_number: '2025550136', email: 'j.doe@tamu.edu')
        Schedule.create!(user_id: user.id, recurrence: 'MWF')

        visit 'schedules/admins'
        css = "tr##{user.id} td.recur"
        cells = page.all(css)
        expect(cells.size).to(eq(3))
    end

    scenario 'content information display' do
        user = User.create!(is_admin: true, is_staff: true, first_name: 'John', last_name: 'Doe', classification: 'Senior', skill_level: 'Advanced', phone_number: '2025550136', email: 'j.doe@tamu.edu')
        schedule = Schedule.create!(user_id: user.id, recurrence: 'MWF')
        Attendance.create!(schedule_id: schedule.id, date: '2023-03-15', check_in_time: nil, purpose: 'Training')

        visit 'schedules/admins'
        css = "tr##{user.id} td.attendance"
        td = find(css).text

        expect(td).to(have_content('Horse: None'))
        expect(td).to(have_content('Event: Training'))
    end
    
    scenario 'user with no schedule is indicated' do
        user = User.create!(is_admin: true, is_staff: true, first_name: 'John', last_name: 'Doe', classification: 'Senior', skill_level: 'Advanced', phone_number: '2025550136', email: 'j.doe@tamu.edu')
        
        visit 'schedules/admins'

        expect(page).to(have_css('no-schedule'))
    end

    scenario 'current week is displayed' do
        visit 'schedules/admins'

        today = Date.today
        monday_date = today.at_beginning_of_week.strftime('%d')
        monday_month = today.at_beginning_of_week.strftime('%B')

        expected_string = monday_month + ' ' + monday_date
        expect(page).to(have_content(expected_string))
    end

    scenario 'can switch weeks' do
        visit 'schedules/admins'

        click_on 'Last Week'

        today = Date.today
        last_week = (today - 7)
        last_monday_date = last_week.at_beginning_of_week.strftime('%d')
        last_monday_month = last_week.at_beginning_of_week.strftime('%B')

        expected_string = last_monday_month + ' ' + last_monday_date
        expect(page).to(have_content(expected_string))
    end
end
