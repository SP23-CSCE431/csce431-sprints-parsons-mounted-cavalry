require 'rails_helper'

RSpec.describe 'Creating an Attendance record', type: :feature do
    scenario 'valid inputs' do
      visit new_attendance_path
      fill_in "attendance[cadet_id]", with: 1
      fill_in "attendance[horse_id]", with: 1
      fill_in "attendance[staff_id]", with: 1
      fill_in "attendance[appointment_time]", with: '01/01/2023 10:00 AM'
      fill_in "attendance[check_in_time]", with: '01/01/2023 11:00 AM'
      fill_in "attendance[check_out_time]", with: '01/01/2023 12:00 PM'
      fill_in "attendance[purpose]", with: 'Training'
      click_on 'Create Attendance'
      expect(page).to have_content('Attendance was successfully created.')
    end
end
  
RSpec.describe 'Viewing an Attendance record', type: :feature do
    scenario 'valid inputs' do
        attendance = Attendance.create(cadet_id: 1, horse_id: 1, staff_id: 1, appointment_time: '01/01/2023 10:00 AM', check_in_time: '01/01/2023 11:00 AM', check_out_time: '01/01/2023 12:00 PM', purpose: 'Training')
        visit attendance_path(id: attendance.id)
        expect(page).to have_content('Cadet Id')
        expect(page).to have_content('Horse Id')
        expect(page).to have_content('Staff Id')
        expect(page).to have_content('Appointment time')
        expect(page).to have_content('Check in time')
        expect(page).to have_content('Check out time')
        expect(page).to have_content('Purpose')
    end
end

RSpec.describe 'Editing an attendance record', type: :feature do
    scenario 'valid inputs' do
        attendance = Attendance.create(attendance_id: 1, cadet_id: 1, horse_id: 1, staff_id: 1, appointment_time: '01/01/2022 10:00:00', check_in_time: '01/01/2022 10:30:00', check_out_time: '01/01/2022 11:00:00', purpose: 'Training session')
        visit edit_attendance_path(id: attendance.id)
        fill_in "attendance[attendance_id]", with: 2
        fill_in "attendance[cadet_id]", with: 2
        fill_in "attendance[horse_id]", with: 2
        fill_in "attendance[staff_id]", with: 2
        fill_in "attendance[appointment_time]", with: '01/02/2022 10:00:00'
        fill_in "attendance[check_in_time]", with: '01/02/2022 10:30:00'
        fill_in "attendance[check_out_time]", with: '01/02/2022 11:00:00'
        fill_in "attendance[purpose]", with: 'Training session 2'
        click_on 'Update Attendance'
        expect(page).to have_content('Attendance was successfully updated.')
    end
end
    
RSpec.describe 'Destroying an attendance record', type: :feature do
    scenario 'valid inputs' do
        attendance = Attendance.create(attendance_id: 2, cadet_id: 2, horse_id: 2, staff_id: 2, appointment_time: '01/02/2022 10:00:00', check_in_time: '01/02/2022 10:30:00', check_out_time: '01/02/2022 11:00:00', purpose: 'Training session 2')
        visit attendance_path(id: attendance.id)
        click_on 'Destroy this attendance record'
        expect(page).to have_content('Attendance was successfully destroyed.')
    end
end
