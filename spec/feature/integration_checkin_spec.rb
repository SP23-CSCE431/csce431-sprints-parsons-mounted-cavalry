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

    it 'valid check in time' do
        user = User.where(:email => 'tony@tamu.edu').first
        schedule = Schedule.create(user_id: user.id, recurrence: %w[M W F])
        horse = Horse.create(name: 'Ed', brand: 'B12', herd: 'Charlie', difficulty: 'Intermediate', condition: 'Healthy')
        Attendance.create(schedule_id: schedule.id, horse_id: horse.id, date: Date.today.strftime, purpose: "Ride")

        visit 'pages/checkin_cadets'
        expect(page).to(have_content(Date.today.strftime("%b %-d, %Y")))
        expect(page).to(have_content('Ride'))
        expect(page).to(have_content('Ed - B12'))
    end

    it 'valid nothing scheduled' do
        user = User.where(:email => 'tony@tamu.edu').first
        Schedule.create(user_id: user.id, recurrence: %w[M W F])
        Horse.create(name: 'Ed', brand: 'B12', herd: 'Charlie', difficulty: 'Intermediate', condition: 'Healthy')

        visit 'pages/checkin_cadets'
        expect(page).to(have_content('You have nothing scheduled for today!'))
    end
end

# testing check in functionality
RSpec.describe('Staff checking in', type: :feature) do
    # sunny day
    before do
        User.create(is_admin: false, is_staff: true, first_name: 'John', last_name: 'Doe', classification: 'Senior', skill_level: 'Advanced', phone_number: '2025550136', email: 'tony@tamu.edu')
        Rails.application.env_config["devise.mapping"] = Devise.mappings[:admin]
        Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
        visit root_path
        click_on 'Sign in with Google'
    end

    it 'valid check in time' do
        user = User.where(:email => 'tony@tamu.edu').first
        schedule = Schedule.create(user_id: user.id, recurrence: %w[M W F])
        horse = Horse.create(name: 'Ed', brand: 'B12', herd: 'Charlie', difficulty: 'Intermediate', condition: 'Healthy')
        Attendance.create(schedule_id: schedule.id, horse_id: horse.id, date: Date.today.strftime, purpose: "Ride")

        visit 'pages/checkin_staffs'
        expect(page).to(have_content(Date.today.strftime("%b %-d, %Y")))
        expect(page).to(have_content('Ride'))
        expect(page).to(have_content('Ed - B12'))
    end

    it 'valid nothing scheduled' do
        user = User.where(:email => 'tony@tamu.edu').first
        Schedule.create(user_id: user.id, recurrence: %w[M W F])
        Horse.create(name: 'Ed', brand: 'B12', herd: 'Charlie', difficulty: 'Intermediate', condition: 'Healthy')

        visit 'pages/checkin_staffs'
        expect(page).to(have_content('You have nothing scheduled for today!'))
    end
end
