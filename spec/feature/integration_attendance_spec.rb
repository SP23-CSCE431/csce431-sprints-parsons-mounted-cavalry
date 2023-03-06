require 'rails_helper'

# testing creation of attendance
RSpec.describe 'Creating an attendance', type: :feature do
    # sunny day
    scenario 'valid inputs' do
        user = User.create(is_admin: true, is_staff: true, first_name: 'John', last_name: 'Doe', classification: 'Senior', skill_level: 'Advanced', phone_number: '8229852917', email: 'j.doe@tamu.edu')
        schedule = Schedule.create(user_id: user.id, recurrence: 'MWF')
        horse = Horse.create(name: 'Ed', brand: 'B12', herd: 'Charlie', difficulty: 'Intermediate', condition: 'Healthy')

        visit new_attendance_path
        find('#attendance_schedule_id').find(:xpath, 'option[1]').select_option
        find('#attendance_horse_id').find(:xpath, 'option[2]').select_option
        fill_in 'attendance[date]', with: '2023-12-25'
        select 'Training', :from => 'attendance[purpose]'
        click_on 'Create Attendance'
        expect(page).to have_content('Attendance was successfully created.')
    end
    
    # sunny day
    scenario 'no horse selected' do
        user = User.create(is_admin: true, is_staff: true, first_name: 'John', last_name: 'Doe', classification: 'Senior', skill_level: 'Advanced', phone_number: '8229852917', email: 'j.doe@tamu.edu')
        schedule = Schedule.create(user_id: user.id, recurrence: 'MWF')

        visit new_attendance_path
        find('#attendance_schedule_id').find(:xpath, 'option[1]').select_option
        fill_in 'attendance[date]', with: '2023-12-25'
        select 'Training', :from => 'attendance[purpose]'
        click_on 'Create Attendance'
        expect(page).to have_content('Attendance was successfully created.')
    end

    # rainy day
    scenario 'no date input' do
        user = User.create(is_admin: true, is_staff: true, first_name: 'John', last_name: 'Doe', classification: 'Senior', skill_level: 'Advanced', phone_number: '8229852917', email: 'j.doe@tamu.edu')
        schedule = Schedule.create(user_id: user.id, recurrence: 'MWF')
        horse = Horse.create(name: 'Ed', brand: 'B12', herd: 'Charlie', difficulty: 'Intermediate', condition: 'Healthy')

        visit new_attendance_path
        find('#attendance_schedule_id').find(:xpath, 'option[1]').select_option
        find('#attendance_horse_id').find(:xpath, 'option[2]').select_option
        select 'Training', :from => 'attendance[purpose]'
        click_on 'Create Attendance'
        expect(page).to have_content('Date can\'t be blank')
    end
end

# testing view of attendance
RSpec.describe 'Viewing an attendance', type: :feature do
    scenario 'valid inputs' do
        user = User.create(is_admin: true, is_staff: true, first_name: 'John', last_name: 'Doe', classification: 'Senior', skill_level: 'Advanced', phone_number: '8229852917', email: 'j.doe@tamu.edu')
        schedule = Schedule.create(user_id: user.id, recurrence: 'MWF')
        attendance = Attendance.create(schedule_id: schedule.id, date: '2023-12-25', check_in_time: nil, purpose: 'Training')
        visit attendance_path(id: attendance.id)
        expect(page).to have_content('John Doe')
        expect(page).to have_content('None')
        expect(page).to have_content('2023-12-25')
        expect(page).to have_content('Not checked in')
        expect(page).to have_content('Training')
    end
end

# testing updating of attendance
RSpec.describe 'Updating an attendance', type: :feature do
    # sunny day
    scenario 'valid inputs' do
        user = User.create(is_admin: true, is_staff: true, first_name: 'John', last_name: 'Doe', classification: 'Senior', skill_level: 'Advanced', phone_number: '8229852917', email: 'j.doe@tamu.edu')
        schedule = Schedule.create(user_id: user.id, recurrence: 'MWF')
        horse = Horse.create(name: 'Ed', brand: 'B12', herd: 'Charlie', difficulty: 'Intermediate', condition: 'Healthy')

        user2 = User.create(is_admin: true, is_staff: true, first_name: 'Jane', last_name: 'Doe', classification: 'Senior', skill_level: 'Advanced', phone_number: '8229852917', email: 'j.doe@tamu.edu')
        schedule2 = Schedule.create(user_id: user2.id, recurrence: 'MWF')
        horse2 = Horse.create(name: 'Horsey', brand: 'A711', herd: 'Bravo', difficulty: 'Advanced', condition: 'Healthy')
        attendance = Attendance.create(schedule_id: schedule.id, date: '2023-12-25', check_in_time: nil, purpose: 'Training')
      
        visit edit_attendance_path(id: attendance.id)
        find(:xpath, "//*[@id='attendance_schedule_id']/option[@value='#{schedule2.id}']").select_option
        find(:xpath, "//*[@id='attendance_horse_id']/option[@value='#{horse2.id}']").select_option
        fill_in 'attendance[date]', with: '2022-06-07'
        select 'Ride & Work', :from => 'attendance[purpose]'
        click_on 'Update Attendance'
        expect(page).to have_content('Attendance was successfully updated.')
    end

    # sunny day
    scenario 'deselect a horse' do
        user = User.create(is_admin: true, is_staff: true, first_name: 'John', last_name: 'Doe', classification: 'Senior', skill_level: 'Advanced', phone_number: '8229852917', email: 'j.doe@tamu.edu')
        schedule = Schedule.create(user_id: user.id, recurrence: 'MWF')
        horse = Horse.create(name: 'Ed', brand: 'B12', herd: 'Charlie', difficulty: 'Intermediate', condition: 'Healthy')

        user2 = User.create(is_admin: true, is_staff: true, first_name: 'Jane', last_name: 'Doe', classification: 'Senior', skill_level: 'Advanced', phone_number: '8229852917', email: 'j.doe@tamu.edu')
        schedule2 = Schedule.create(user_id: user2.id, recurrence: 'MWF')
        attendance = Attendance.create(schedule_id: schedule.id, date: '2023-12-25', check_in_time: nil, purpose: 'Training')
        
        visit edit_attendance_path(id: attendance.id)
        find(:xpath, "//*[@id='attendance_schedule_id']/option[@value='#{schedule2.id}']").select_option
        find(:xpath, "//*[@id='attendance_horse_id']/option[1]").select_option
        fill_in 'attendance[date]', with: '2022-06-07'
        select 'Ride & Work', :from => 'attendance[purpose]'
        click_on 'Update Attendance'
        expect(page).to have_content('Attendance was successfully updated.')
    end

    # rainy day
    scenario 'update with no date' do
        user = User.create(is_admin: true, is_staff: true, first_name: 'John', last_name: 'Doe', classification: 'Senior', skill_level: 'Advanced', phone_number: '8229852917', email: 'j.doe@tamu.edu')
        schedule = Schedule.create(user_id: user.id, recurrence: 'MWF')
        horse = Horse.create(name: 'Ed', brand: 'B12', herd: 'Charlie', difficulty: 'Intermediate', condition: 'Healthy')

        attendance = Attendance.create(schedule_id: schedule.id, date: '2023-12-25', check_in_time: nil, purpose: 'Training')  
        visit edit_attendance_path(id: attendance.id)
        fill_in 'attendance[date]', with: ''
        click_on 'Update Attendance'
        expect(page).to have_content('Date can\'t be blank')
    end
end

# testing deletion of attendance
RSpec.describe 'Deleting an attendance', type: :feature do
    # sunny day
    scenario 'valid inputs' do
        user = User.create(is_admin: true, is_staff: true, first_name: 'John', last_name: 'Doe', classification: 'Senior', skill_level: 'Advanced', phone_number: '8229852917', email: 'j.doe@tamu.edu')
        schedule = Schedule.create(user_id: user.id, recurrence: 'MWF')
        horse = Horse.create(name: 'Ed', brand: 'B12', herd: 'Charlie', difficulty: 'Intermediate', condition: 'Healthy')

        attendance = Attendance.create(schedule_id: schedule.id, date: '2023-12-25', check_in_time: nil, purpose: 'Training')
        visit delete_attendance_path(id: attendance.id)
        click_on 'Delete attendance'
        expect(page).to have_content('Attendance was successfully destroyed.')
    end

    # if an attendance belongs to a schedule, then when that schedule is deleted
    # the attendance must be deleted as well
    scenario 'schedule that has attendance is deleted' do
        user = User.create(is_admin: true, is_staff: true, first_name: 'Jane', last_name: 'Doe', classification: 'Senior', skill_level: 'Advanced', phone_number: '8229852917', email: 'j.doe@tamu.edu')
        schedule = Schedule.create(user_id: user.id, recurrence: 'MWF')
        attendance = Attendance.create(schedule_id: schedule.id, date: '2023-12-25', check_in_time: nil, purpose: 'Training')
        
        visit attendance_path(id: attendance.id)
        expect(page).to have_content('Jane Doe')
        schedule.destroy
        expect { visit attendance_path(id: attendance.id) }.to raise_error(ActiveRecord::RecordNotFound)        
    end

    # if an attendance belongs to a user, then when that user is deleted
    # the attendance must be deleted as well
    scenario 'user that has attendance is deleted' do
        user = User.create(is_admin: true, is_staff: true, first_name: 'Jane', last_name: 'Doe', classification: 'Senior', skill_level: 'Advanced', phone_number: '8229852917', email: 'j.doe@tamu.edu')
        schedule = Schedule.create(user_id: user.id, recurrence: 'MWF')
        attendance = Attendance.create(schedule_id: schedule.id, date: '2023-12-25', check_in_time: nil, purpose: 'Training')
        
        visit attendance_path(id: attendance.id)
        expect(page).to have_content('Jane Doe')
        user.destroy
        expect { visit attendance_path(id: attendance.id) }.to raise_error(ActiveRecord::RecordNotFound)        
    end
end
