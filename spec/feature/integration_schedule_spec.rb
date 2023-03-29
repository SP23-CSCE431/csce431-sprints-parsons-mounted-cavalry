require 'rails_helper'

RSpec.feature "Schedules", type: :feature do
  before(:each) do
    Rails.application.env_config["devise.mapping"] = Devise.mappings[:admin]
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
    visit root_path
    click_on 'Sign in with Google'
  end

  scenario "user creates a schedule" do
    user = User.create(is_admin: true, is_staff: true, first_name: 'John', last_name: 'Doe', classification: 'Senior', skill_level: 'Advanced', phone_number: '8229852917', email: 'j.doe@tamu.edu')
    schedule = Schedule.create(user_id: user.id, recurrence: 'MWF')

    visit new_schedule_path
    fill_in "User", with: @schedule.user_id
    fill_in "Recurrence", with: @schedule.recurrence
    click_on "Create Schedule"
    expect(page).to have_text("Schedule was successfully created.")
  end

  scenario "user edits a schedule" do
    visit edit_schedule_path(@schedule)
    fill_in "Recurrence", with: "New recurrence"
    click_on "Update Schedule"
    expect(page).to have_text("Schedule was successfully updated.")
  end

  scenario "user deletes a schedule" do
    visit schedules_path
    click_on "Destroy", href: schedule_path(@schedule)
    expect(page).to have_text("Schedule was successfully destroyed.")
  end
end
