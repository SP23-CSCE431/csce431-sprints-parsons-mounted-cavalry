require 'rails_helper'

RSpec.describe('Creating a schedule', type: :feature) do
  before do
    User.create(is_admin: true, is_staff: true, first_name: 'John', last_name: 'Doe', classification: 'Senior', skill_level: 'Advanced', phone_number: '2025550136', email: 'tony@tamu.edu')
    Rails.application.env_config["devise.mapping"] = Devise.mappings[:admin]
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
    visit root_path
    click_on 'Sign in with Google'
  end

  scenario 'valid inputs - calendar view' do
    user = User.create(is_admin: true, is_staff: true, first_name: 'John', last_name: 'Doe', classification: 'Senior', skill_level: 'Advanced', phone_number: '2025550136', email: 'j.doe@tamu.edu')
    
    visit 'schedules/admins'

    css_path = 'tr#' + user.id.to_s + ' > th > a'
    find(:css, css_path).click
    
    find(:css, '#schedule_recurrence_m').set(true)
    find(:css, '#schedule_recurrence_t').set(true)
    find(:css, '#schedule_recurrence_r').set(true)

    click_on 'Create Schedule'
    expect(page).to(have_content('Schedule was successfully created.'))
  end

  scenario 'no recurrence given - calendar view' do
    user = User.create(is_admin: true, is_staff: true, first_name: 'John', last_name: 'Doe', classification: 'Senior', skill_level: 'Advanced', phone_number: '2025550136', email: 'j.doe@tamu.edu')
    
    visit 'schedules/admins'
    
    css_path = 'tr#' + user.id.to_s + ' > th > a'
    find(:css, css_path).click

    click_on 'Create Schedule'
    expect(page).to(have_content('Recurrence can\'t be blank'))
  end
end

RSpec.describe('Viewing a schedule', type: :feature) do
  before do
    User.create(is_admin: true, is_staff: true, first_name: 'John', last_name: 'Doe', classification: 'Senior', skill_level: 'Advanced', phone_number: '2025550136', email: 'tony@tamu.edu')
    Rails.application.env_config["devise.mapping"] = Devise.mappings[:admin]
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
    visit root_path
    click_on 'Sign in with Google'
  end

  scenario 'valid inputs - table view' do
    user = User.create(is_admin: true, is_staff: true, first_name: 'John', last_name: 'Doe', classification: 'Senior', skill_level: 'Advanced', phone_number: '2025550136', email: 'j.doe@tamu.edu')
    schedule = Schedule.create(user_id: user.id, recurrence: ['M', 'W', 'F'])

    visit 'schedules/admins'
    find(:css, '.all-schedules').click

    expect(page).to(have_content('John Doe'))
    expect(page).to(have_content('Mon, Wed, Fri'))
  end

  scenario 'valid inputs - calendar view' do
    user = User.create(is_admin: true, is_staff: true, first_name: 'John', last_name: 'Doe', classification: 'Senior', skill_level: 'Advanced', phone_number: '2025550136', email: 'j.doe@tamu.edu')
    schedule = Schedule.create(user_id: user.id, recurrence: ['M', 'W', 'F'])

    visit 'schedules/admins'
    
    css_path = 'tr#' + user.id.to_s + ' > th > a'
    find(:css, css_path).click

    expect(page).to(have_content('John Doe'))
    expect(page).to(have_content('Mon, Wed, Fri'))
  end
end

RSpec.describe('Editing a schedule', type: :feature) do
  before do
    User.create(is_admin: true, is_staff: true, first_name: 'John', last_name: 'Doe', classification: 'Senior', skill_level: 'Advanced', phone_number: '2025550136', email: 'tony@tamu.edu')
    Rails.application.env_config["devise.mapping"] = Devise.mappings[:admin]
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
    visit root_path
    click_on 'Sign in with Google'
  end

  scenario 'valid inputs - table view' do
    user = User.create(is_admin: true, is_staff: true, first_name: 'John', last_name: 'Doe', classification: 'Senior', skill_level: 'Advanced', phone_number: '2025550136', email: 'j.doe@tamu.edu')
    schedule = Schedule.create(user_id: user.id, recurrence: ['M', 'W', 'F'])

    visit 'schedules/admins'
    find(:css, '.all-schedules').click

    css_path = '#edit-' + schedule.id.to_s + ' > center > a'
    find(:css, css_path).click

    find(:css, '#schedule_recurrence_m').set(false)
    find(:css, '#schedule_recurrence_t').set(true)
    find(:css, '#schedule_recurrence_f').set(false)

    click_on 'Update Schedule'
    expect(page).to(have_content('Schedule was successfully updated.'))
  end

  scenario 'valid inputs - calendar view' do
    user = User.create(is_admin: true, is_staff: true, first_name: 'John', last_name: 'Doe', classification: 'Senior', skill_level: 'Advanced', phone_number: '2025550136', email: 'j.doe@tamu.edu')
    schedule = Schedule.create(user_id: user.id, recurrence: ['M', 'W', 'F'])

    visit 'schedules/admins'
    
    
    css_path = 'tr#' + user.id.to_s + ' > th > a'
    find(:css, css_path).click
    
    find(:css, '.edit-schedule-btn').click
    
    find(:css, '#schedule_recurrence_m').set(false)
    find(:css, '#schedule_recurrence_t').set(true)
    find(:css, '#schedule_recurrence_f').set(false)

    click_on 'Update Schedule'
    expect(page).to(have_content('Schedule was successfully updated.'))
  end

  scenario 'recurrence changed to nothing - table view' do
    user = User.create(is_admin: true, is_staff: true, first_name: 'John', last_name: 'Doe', classification: 'Senior', skill_level: 'Advanced', phone_number: '2025550136', email: 'j.doe@tamu.edu')
    schedule = Schedule.create(user_id: user.id, recurrence: ['M', 'W', 'F'])

    visit 'schedules/admins'

    find(:css, '.all-schedules').click

    css_path = '#edit-' + schedule.id.to_s + ' > center > a'
    find(:css, css_path).click

    find(:css, '#schedule_recurrence_m').set(false)
    find(:css, '#schedule_recurrence_w').set(false)
    find(:css, '#schedule_recurrence_f').set(false)

    click_on 'Update Schedule'
    expect(page).to(have_content('Recurrence can\'t be blank'))
  end

  scenario 'recurrence changed to nothing - calendar view' do
    user = User.create(is_admin: true, is_staff: true, first_name: 'John', last_name: 'Doe', classification: 'Senior', skill_level: 'Advanced', phone_number: '2025550136', email: 'j.doe@tamu.edu')
    schedule = Schedule.create(user_id: user.id, recurrence: ['M', 'W', 'F'])

    visit 'schedules/admins'
    
    css_path = 'tr#' + user.id.to_s + ' > th > a'
    find(:css, css_path).click
    
    find(:css, '.edit-schedule-btn').click
    
    find(:css, '#schedule_recurrence_m').set(false)
    find(:css, '#schedule_recurrence_w').set(false)
    find(:css, '#schedule_recurrence_f').set(false)

    click_on 'Update Schedule'
    expect(page).to(have_content('Recurrence can\'t be blank'))
  end
end

RSpec.describe('Deleting a schedule', type: :feature) do
  before do
    User.create(is_admin: true, is_staff: true, first_name: 'John', last_name: 'Doe', classification: 'Senior', skill_level: 'Advanced', phone_number: '2025550136', email: 'tony@tamu.edu')
    Rails.application.env_config["devise.mapping"] = Devise.mappings[:admin]
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
    visit root_path
    click_on 'Sign in with Google'
  end

  scenario 'valid inputs - table view' do
    user = User.create(is_admin: true, is_staff: true, first_name: 'John', last_name: 'Doe', classification: 'Senior', skill_level: 'Advanced', phone_number: '2025550136', email: 'j.doe@tamu.edu')
    schedule = Schedule.create(user_id: user.id, recurrence: ['M', 'W', 'F'])

    visit 'schedules/admins'
    
    find(:css, '.all-schedules').click

    css_path = '#delete-' + schedule.id.to_s + ' > center > a'
    find(:css, css_path).click

    click_on 'Delete'
    expect(page).to(have_content('Schedule was successfully deleted.'))
  end

  scenario 'valid inputs - calendar view' do
    user = User.create(is_admin: true, is_staff: true, first_name: 'John', last_name: 'Doe', classification: 'Senior', skill_level: 'Advanced', phone_number: '2025550136', email: 'j.doe@tamu.edu')
    schedule = Schedule.create(user_id: user.id, recurrence: ['M', 'W', 'F'])

    visit 'schedules/admins'
    
    css_path = 'tr#' + user.id.to_s + ' > th > a'
    find(:css, css_path).click
    
    find(:css, '.delete-schedule-btn').click

    click_on 'Delete'
    expect(page).to(have_content('Schedule was successfully deleted.'))
  end
end
