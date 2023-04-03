# frozen_string_literal: true

require "rails_helper"

RSpec.describe UsageCounterComponent, type: :component do
  before do
    User.create(is_admin: true, is_staff: true, first_name: 'John', last_name: 'Doe', classification: 'Senior', skill_level: 'Advanced', phone_number: '2025550136', email: 'tony@tamu.edu')
    Rails.application.env_config["devise.mapping"] = Devise.mappings[:admin]
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
    visit root_path
    click_on 'Sign in with Google'
  end

  scenario 'usage counter shows horse usage' do
    user = User.create(is_admin: true, is_staff: true, first_name: 'John', last_name: 'Doe', classification: 'Senior', skill_level: 'Advanced', phone_number: '2025550136', email: 'j.doe@tamu.edu')
    schedule = Schedule.create(user_id: user.id, recurrence: 'MWF')
    horse = Horse.create(name: 'Horsey', brand: 'H1199', herd: 'Alpha', difficulty: 'Easy', condition: 'Healthy')

    visit 'schedules/admins'
    click_on 'usage_counter'

    expect(page).not_to(have_content('Horsey - H1199'))

    Attendance.create(schedule_id: schedule.id, date: '2023-03-15', check_in_time: nil, purpose: 'Training')

    expect(page).to(have_content('Horsey - H1199'))
    expect(page).to(have_content('1'))
  end

  scenario 'usage counter shows user usage' do
    user = User.create(is_admin: true, is_staff: true, first_name: 'John', last_name: 'Doe', classification: 'Senior', skill_level: 'Advanced', phone_number: '2025550136', email: 'j.doe@tamu.edu')
    schedule = Schedule.create(user_id: user.id, recurrence: 'MWF')
    horse = Horse.create(name: 'Horsey', brand: 'H1199', herd: 'Alpha', difficulty: 'Easy', condition: 'Healthy')
    Attendance.create(schedule_id: schedule.id, date: '2023-03-15', check_in_time: nil, purpose: 'Training')
    
    visit 'schedules/admins'
    click_on 'usage_counter'
    click_on 'users_usage'

    expect(page).not_to(have_content('John Doe'))

    Attendance.create(schedule_id: schedule.id, date: '2023-03-15', check_in_time: nil, purpose: 'Training')

    expect(page).to(have_content('John Doe'))
    expect(page).to(have_content('1'))
  end
end
