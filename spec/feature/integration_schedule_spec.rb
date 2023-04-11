require 'rails_helper'

RSpec.describe('Creating a schedule', type: :feature) do
  before do
    User.create(is_admin: true, is_staff: true, first_name: 'John', last_name: 'Doe', classification: 'Senior', skill_level: 'Advanced', phone_number: '2025550136', email: 'tony@tamu.edu')
    Rails.application.env_config["devise.mapping"] = Devise.mappings[:admin]
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
    visit root_path
    click_on 'Sign in with Google'
  end

  it 'valid inputs - calendar view' do
    user = User.create(is_admin: false, is_staff: true, first_name: 'John', last_name: 'Doe', classification: 'Senior', skill_level: 'Advanced', phone_number: '2025550136', email: 'j.doe@tamu.edu')

    visit 'schedules/admins'

    css_path = "tr##{user.id} > th > a"
    find(:css, css_path).click

    find(:css, '#schedule_recurrence_m').set(true)
    find(:css, '#schedule_recurrence_t').set(true)
    find(:css, '#schedule_recurrence_r').set(true)

    click_on 'Create Schedule'
    expect(page).to(have_content('Schedule was successfully created.'))
  end

  it 'no recurrence given - calendar view' do
    user = User.create(is_admin: false, is_staff: true, first_name: 'John', last_name: 'Doe', classification: 'Senior', skill_level: 'Advanced', phone_number: '2025550136', email: 'j.doe@tamu.edu')

    visit 'schedules/admins'

    css_path = "tr##{user.id} > th > a"
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

  it 'valid inputs - table view' do
    user = User.create(is_admin: false, is_staff: true, first_name: 'John', last_name: 'Doe', classification: 'Senior', skill_level: 'Advanced', phone_number: '2025550136', email: 'j.doe@tamu.edu')
    Schedule.create(user_id: user.id, recurrence: %w[M W F])

    visit 'schedules/admins'
    find(:css, '.all-schedules').click

    expect(page).to(have_content('John Doe'))
    expect(page).to(have_content('Mon, Wed, Fri'))
  end

  it 'valid inputs - calendar view' do
    user = User.create(is_admin: false, is_staff: true, first_name: 'John', last_name: 'Doe', classification: 'Senior', skill_level: 'Advanced', phone_number: '2025550136', email: 'j.doe@tamu.edu')
    Schedule.create(user_id: user.id, recurrence: %w[M W F])

    visit 'schedules/admins'

    css_path = "tr##{user.id} > th > a"
    find(:css, css_path).click

    expect(page).to(have_content('John Doe'))
    expect(page).to have_field('schedule_recurrence_m', checked: true)
    expect(page).to have_field('schedule_recurrence_w', checked: true)
    expect(page).to have_field('schedule_recurrence_f', checked: true)
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

  it 'valid inputs - table view' do
    user = User.create(is_admin: false, is_staff: true, first_name: 'John', last_name: 'Doe', classification: 'Senior', skill_level: 'Advanced', phone_number: '2025550136', email: 'j.doe@tamu.edu')
    schedule = Schedule.create(user_id: user.id, recurrence: %w[M W F])

    visit 'schedules/admins'
    find(:css, '.all-schedules').click

    css_path = "#edit-#{schedule.id} > center > a"
    find(:css, css_path).click

    find(:css, '#schedule_recurrence_m').set(false)
    find(:css, '#schedule_recurrence_t').set(true)
    find(:css, '#schedule_recurrence_f').set(false)

    click_on 'Update Schedule'
    expect(page).to(have_content('Schedule was successfully updated.'))
  end

  it 'valid inputs - calendar view' do
    user = User.create(is_admin: false, is_staff: true, first_name: 'John', last_name: 'Doe', classification: 'Senior', skill_level: 'Advanced', phone_number: '2025550136', email: 'j.doe@tamu.edu')
    Schedule.create(user_id: user.id, recurrence: %w[M W F])

    visit 'schedules/admins'

    css_path = "tr##{user.id} > th > a"
    find(:css, css_path).click

    find(:css, '#schedule_recurrence_m').set(false)
    find(:css, '#schedule_recurrence_t').set(true)
    find(:css, '#schedule_recurrence_f').set(false)

    click_on 'Update Schedule'
    expect(page).to(have_content('Schedule was successfully updated.'))
  end

  it 'recurrence changed to nothing - table view' do
    user = User.create(is_admin: false, is_staff: true, first_name: 'John', last_name: 'Doe', classification: 'Senior', skill_level: 'Advanced', phone_number: '2025550136', email: 'j.doe@tamu.edu')
    schedule = Schedule.create(user_id: user.id, recurrence: %w[M W F])

    visit 'schedules/admins'

    find(:css, '.all-schedules').click

    css_path = "#edit-#{schedule.id} > center > a"
    find(:css, css_path).click

    find(:css, '#schedule_recurrence_m').set(false)
    find(:css, '#schedule_recurrence_w').set(false)
    find(:css, '#schedule_recurrence_f').set(false)

    click_on 'Update Schedule'
    expect(page).to(have_content('Recurrence can\'t be blank'))
  end

  it 'recurrence changed to nothing - calendar view' do
    user = User.create(is_admin: false, is_staff: true, first_name: 'John', last_name: 'Doe', classification: 'Senior', skill_level: 'Advanced', phone_number: '2025550136', email: 'j.doe@tamu.edu')
    Schedule.create(user_id: user.id, recurrence: %w[M W F])

    visit 'schedules/admins'

    css_path = "tr##{user.id} > th > a"
    find(:css, css_path).click

    find(:css, '#schedule_recurrence_m').set(false)
    find(:css, '#schedule_recurrence_w').set(false)
    find(:css, '#schedule_recurrence_f').set(false)

    click_on 'Update Schedule'
    expect(page).to(have_content('Recurrence can\'t be blank'))
  end
end

RSpec.describe('Deleting a schedule', type: :feature) do
  before do
    User.create(is_admin: false, is_staff: true, first_name: 'John', last_name: 'Doe', classification: 'Senior', skill_level: 'Advanced', phone_number: '2025550136', email: 'tony@tamu.edu')
    Rails.application.env_config["devise.mapping"] = Devise.mappings[:admin]
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
    visit root_path
    click_on 'Sign in with Google'
  end

  it 'valid inputs - table view' do
    user = User.create(is_admin: true, is_staff: true, first_name: 'John', last_name: 'Doe', classification: 'Senior', skill_level: 'Advanced', phone_number: '2025550136', email: 'j.doe@tamu.edu')
    schedule = Schedule.create(user_id: user.id, recurrence: %w[M W F])

    visit 'schedules/admins'

    find(:css, '.all-schedules').click

    css_path = "#delete-#{schedule.id} > center > a"
    find(:css, css_path).click

    click_on 'Delete'
    expect(page).to(have_content('Schedule was successfully deleted.'))
  end
end
