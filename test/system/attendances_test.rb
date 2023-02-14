require "application_system_test_case"

class AttendancesTest < ApplicationSystemTestCase
  setup do
    @attendance = attendances(:one)
  end

  test "visiting the index" do
    visit attendances_url
    assert_selector "h1", text: "Attendances"
  end

  test "should create attendance" do
    visit attendances_url
    click_on "New attendance"

    fill_in "Appointment time", with: @attendance.appointment_time
    fill_in "Attendance", with: @attendance.attendance_id
    fill_in "Cadet", with: @attendance.cadet_id
    fill_in "Check in time", with: @attendance.check_in_time
    fill_in "Check out time", with: @attendance.check_out_time
    fill_in "Horse", with: @attendance.horse_id
    fill_in "Purpose", with: @attendance.purpose
    fill_in "Staff", with: @attendance.staff_id
    click_on "Create Attendance"

    assert_text "Attendance was successfully created"
    click_on "Back"
  end

  test "should update Attendance" do
    visit attendance_url(@attendance)
    click_on "Edit this attendance", match: :first

    fill_in "Appointment time", with: @attendance.appointment_time
    fill_in "Attendance", with: @attendance.attendance_id
    fill_in "Cadet", with: @attendance.cadet_id
    fill_in "Check in time", with: @attendance.check_in_time
    fill_in "Check out time", with: @attendance.check_out_time
    fill_in "Horse", with: @attendance.horse_id
    fill_in "Purpose", with: @attendance.purpose
    fill_in "Staff", with: @attendance.staff_id
    click_on "Update Attendance"

    assert_text "Attendance was successfully updated"
    click_on "Back"
  end

  test "should destroy Attendance" do
    visit attendance_url(@attendance)
    click_on "Destroy this attendance", match: :first

    assert_text "Attendance was successfully destroyed"
  end
end
