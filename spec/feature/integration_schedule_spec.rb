require 'rails_helper'

RSpec.feature "Schedules", type: :feature do
  before(:each) do
    User.create(is_admin: true, is_staff: true, first_name: 'John', last_name: 'Doe', classification: 'Senior', skill_level: 'Advanced', phone_number: '2025550136', email: 'tony@tamu.edu')
    Rails.application.env_config["devise.mapping"] = Devise.mappings[:admin]
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
    visit root_path
    click_on 'Sign in with Google'
  end
  

  it 'days are highlighted for recurrence' do
    user = User.create!(is_admin: true, is_staff: true, first_name: 'John', last_name: 'Doe', classification: 'Senior', skill_level: 'Advanced', phone_number: '2025550136', email: 'j.doe@tamu.edu')
    Schedule.create!(user_id: user.id, recurrence: 'MWF')

    visit 'schedules/admins'
    css = "tr##{user.id} td.recur"
    cells = page.all(css)
    expect(cells.size).to(eq(3))
  end

  it 'content information display' do
    user = User.create!(is_admin: true, is_staff: true, first_name: 'John', last_name: 'Doe', classification: 'Senior', skill_level: 'Advanced', phone_number: '2025550136', email: 'j.doe@tamu.edu')
    schedule = Schedule.create!(user_id: user.id, recurrence: 'MWF')
    Attendance.create!(schedule_id: schedule.id, date: '2023-03-15', check_in_time: nil, purpose: 'Training')

    visit 'schedules/admins'
    css = "tr##{user.id} td.attendance"
    td = find(css).text

    expect(td).to(have_content('Horse: None'))
    expect(td).to(have_content('Event: Training'))
  end

  # scenario "user creates a schedule" do
  #   user = User.create(is_admin: true, is_staff: true, first_name: 'John', last_name: 'Doe', classification: 'Senior', skill_level: 'Advanced', phone_number: '8229852917', email: 'j.doe@tamu.edu')
  #   schedule = Schedule.create(user_id: user.id, recurrence: 'MWF')

  #   visit new_schedule_path
  #   fill_in "User", with: @schedule.user_id
  #   fill_in "Recurrence", with: @schedule.recurrence
  #   click_on "Create Schedule"
  #   expect(page).to have_text("Schedule was successfully created.")
  # end

  # scenario "user edits a schedule" do
  #   visit edit_schedule_path(@schedule)
  #   fill_in "Recurrence", with: "New recurrence"
  #   click_on "Update Schedule"
  #   expect(page).to have_text("Schedule was successfully updated.")
  # end

  # scenario "user deletes a schedule" do
  #   visit schedules_path
  #   click_on "Destroy", href: schedule_path(@schedule)
  #   expect(page).to have_text("Schedule was successfully destroyed.")
  # end
end
