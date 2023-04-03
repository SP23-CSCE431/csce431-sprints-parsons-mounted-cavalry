require 'rails_helper'

RSpec.describe('Creating a schedule', type: :feature) do
  before do
    User.create(is_admin: true, is_staff: true, first_name: 'John', last_name: 'Doe', classification: 'Senior', skill_level: 'Advanced', phone_number: '2025550136', email: 'tony@tamu.edu')
    Rails.application.env_config["devise.mapping"] = Devise.mappings[:admin]
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
    visit root_path
    click_on 'Sign in with Google'
  end

  scenario 'valid inputs - table view' do
    user = User.create(is_admin: true, is_staff: true, first_name: 'John', last_name: 'Doe', classification: 'Senior', skill_level: 'Advanced', phone_number: '2025550136', email: 'j.doe@tamu.edu')
    
    visit 'schedules/admins'
    click_on 'All Schedules'
    click_on 'John Doe - New'

    find(:css, '#monday').set(true)
    find(:css, '#tuesday').set(true)
    find(:css, '#thursday').set(true)

    click_on 'Create Schedule'
    expect(page).to(have_content('Schedule was successfully created.'))
  end

  scenario 'valid inputs - calendar view' do
    user = User.create(is_admin: true, is_staff: true, first_name: 'John', last_name: 'Doe', classification: 'Senior', skill_level: 'Advanced', phone_number: '2025550136', email: 'j.doe@tamu.edu')
    
    visit 'schedules/admins'
    click_on 'John Doe'
    
    find(:css, '#monday').set(true)
    find(:css, '#tuesday').set(true)
    find(:css, '#thursday').set(true)

    click_on 'Create Schedule'
    expect(page).to(have_content('Schedule was successfully created.'))
  end

  scenario 'no recurrence given - table view' do
    user = User.create(is_admin: true, is_staff: true, first_name: 'John', last_name: 'Doe', classification: 'Senior', skill_level: 'Advanced', phone_number: '2025550136', email: 'j.doe@tamu.edu')
    
    visit 'schedules/admins'
    click_on 'All Schedules'
    click_on 'John Doe - New'

    click_on 'Create Schedule'
    expect(page).to(have_content('Schedule must have recurrence.'))
  end

  scenario 'no recurrence given - calendar view' do
    user = User.create(is_admin: true, is_staff: true, first_name: 'John', last_name: 'Doe', classification: 'Senior', skill_level: 'Advanced', phone_number: '2025550136', email: 'j.doe@tamu.edu')
    
    visit 'schedules/admins'
    click_on 'John Doe'

    click_on 'Create Schedule'
    expect(page).to(have_content('Schedule must have recurrence.'))
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
    schedule = Schedule.create(user_id: user.id, recurrence: 'MWF')

    visit 'schedules/admins'
    click_on 'All Schedules'

    expect(page).to(have_content('John Doe'))
    expect(page).to(have_content('MWF'))
  end

  scenario 'valid inputs - calendar view' do
    user = User.create(is_admin: true, is_staff: true, first_name: 'John', last_name: 'Doe', classification: 'Senior', skill_level: 'Advanced', phone_number: '2025550136', email: 'j.doe@tamu.edu')
    schedule = Schedule.create(user_id: user.id, recurrence: 'MWF')

    visit 'schedules/admins'
    click_on 'John Doe'

    expect(page).to(have_content('John Doe'))
    expect(page).to(have_content('MWF'))
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
    schedule = Schedule.create(user_id: user.id, recurrence: 'MWF')

    visit 'schedules/admins'
    click_on 'All Schedules'
    click_on 'John Doe - Edit'

    find(:css, '#monday').set(false)
    find(:css, '#tuesday').set(true)
    find(:css, '#friday').set(false)

    click_on 'Update Schedule'
    expect(page).to(have_content('Schedule was successfully updated.'))
  end

  scenario 'valid inputs - calendar view' do
    user = User.create(is_admin: true, is_staff: true, first_name: 'John', last_name: 'Doe', classification: 'Senior', skill_level: 'Advanced', phone_number: '2025550136', email: 'j.doe@tamu.edu')
    schedule = Schedule.create(user_id: user.id, recurrence: 'MWF')

    visit 'schedules/admins'
    click_on 'John Doe'
    
    find(:css, '#monday').set(false)
    find(:css, '#tuesday').set(true)
    find(:css, '#thursday').set(false)

    click_on 'Update Schedule'
    expect(page).to(have_content('Schedule was successfully updated.'))
  end

  scenario 'recurrence changed to nothing - table view' do
    user = User.create(is_admin: true, is_staff: true, first_name: 'John', last_name: 'Doe', classification: 'Senior', skill_level: 'Advanced', phone_number: '2025550136', email: 'j.doe@tamu.edu')
    schedule = Schedule.create(user_id: user.id, recurrence: 'MWF')

    visit 'schedules/admins'
    click_on 'All Schedules'
    click_on 'John Doe - Edit'

    find(:css, '#monday').set(false)
    find(:css, '#wednesday').set(false)
    find(:css, '#friday').set(false)

    click_on 'Update Schedule'
    expect(page).to(have_content('Schedule must have recurrence.'))
  end

  scenario 'recurrence changed to nothing - calendar view' do
    user = User.create(is_admin: true, is_staff: true, first_name: 'John', last_name: 'Doe', classification: 'Senior', skill_level: 'Advanced', phone_number: '2025550136', email: 'j.doe@tamu.edu')
    schedule = Schedule.create(user_id: user.id, recurrence: 'MWF')

    visit 'schedules/admins'
    click_on 'John Doe'

    find(:css, '#monday').set(false)
    find(:css, '#wednesday').set(false)
    find(:css, '#friday').set(false)

    click_on 'Update Schedule'
    expect(page).to(have_content('Schedule must have recurrence.'))
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
    schedule = Schedule.create(user_id: user.id, recurrence: 'MWF')

    visit 'schedules/admins'
    click_on 'All Schedules'
    click_on 'John Doe - Delete'

    click_on 'Delete'
    expect(page).to(have_content('Schedule was successfully destroyed.'))
  end

  scenario 'valid inputs - calendar view' do
    user = User.create(is_admin: true, is_staff: true, first_name: 'John', last_name: 'Doe', classification: 'Senior', skill_level: 'Advanced', phone_number: '2025550136', email: 'j.doe@tamu.edu')
    schedule = Schedule.create(user_id: user.id, recurrence: 'MWF')

    visit 'schedules/admins'
    click_on 'John Doe'
    
    click_on 'Delete'

    click_on 'Update Schedule'
    expect(page).to(have_content('Schedule was successfully destroyed.'))
  end
end
