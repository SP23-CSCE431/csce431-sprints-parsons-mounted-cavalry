require "rails_helper"

RSpec.describe 'Usage Counter Component', type: :feature do
  before do
    User.create(is_admin: true, is_staff: true, first_name: 'John', last_name: 'Doe', classification: 'Senior', skill_level: 'Advanced', phone_number: '2025550136', email: 'tony@tamu.edu')
    Rails.application.env_config["devise.mapping"] = Devise.mappings[:admin]
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
    visit root_path
    click_on 'Sign in with Google'
  end

  it 'usage counter shows horse usage' do
    user = User.create(is_admin: true, is_staff: true, first_name: 'John', last_name: 'Doe', classification: 'Senior', skill_level: 'Advanced', phone_number: '2025550136', email: 'j.doe@tamu.edu')
    schedule = Schedule.create(user_id: user.id, recurrence: %w[M W F])
    horse = Horse.create(name: 'Horsey', brand: 'H1199', herd: 'Alpha', difficulty: 'Easy', condition: 'Healthy')
    monday = Date.today.beginning_of_week
    Attendance.create(schedule_id: schedule.id, date: monday.strftime, check_in_time: nil, purpose: 'Training')

    visit 'schedules/admins'

    find_by_id('usage-counter-btn').click

    selector = "tr.horse-usage-#{horse.id} > td"

    expect(page).to(have_selector(selector, text: 'Horsey - H1199'))
  end

  it 'usage counter shows user usage' do
    user = User.create(is_admin: false, is_staff: true, first_name: 'John', last_name: 'Doe', classification: 'Senior', skill_level: 'Advanced', phone_number: '2025550136', email: 'j.doe@tamu.edu')
    schedule = Schedule.create(user_id: user.id, recurrence: %w[M W F])
    Horse.create(name: 'Horsey', brand: 'H1199', herd: 'Alpha', difficulty: 'Easy', condition: 'Healthy')
    monday = Date.today.beginning_of_week
    Attendance.create(schedule_id: schedule.id, date: monday.strftime, check_in_time: nil, purpose: 'Training')

    visit 'schedules/admins'

    find_by_id('usage-counter-btn').click

    selector = "tr.cadet-usage-#{user.id} > td"

    expect(page).to(have_selector(selector, text: 'John Doe'))
  end
end
