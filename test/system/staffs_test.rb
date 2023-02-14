require "application_system_test_case"

class StaffsTest < ApplicationSystemTestCase
  setup do
    @staff = staffs(:one)
  end

  test "visiting the index" do
    visit staffs_url
    assert_selector "h1", text: "Staffs"
  end

  test "should create staff" do
    visit staffs_url
    click_on "New staff"

    fill_in "Email", with: @staff.email
    fill_in "First name", with: @staff.first_name
    check "Is admin" if @staff.is_admin
    fill_in "Last name", with: @staff.last_name
    fill_in "Password", with: @staff.password
    fill_in "Phone number", with: @staff.phone_number
    click_on "Create Staff"

    assert_text "Staff was successfully created"
    click_on "Back"
  end

  test "should update Staff" do
    visit staff_url(@staff)
    click_on "Edit this staff", match: :first

    fill_in "Email", with: @staff.email
    fill_in "First name", with: @staff.first_name
    check "Is admin" if @staff.is_admin
    fill_in "Last name", with: @staff.last_name
    fill_in "Password", with: @staff.password
    fill_in "Phone number", with: @staff.phone_number
    click_on "Update Staff"

    assert_text "Staff was successfully updated"
    click_on "Back"
  end

  test "should destroy Staff" do
    visit staff_url(@staff)
    click_on "Destroy this staff", match: :first

    assert_text "Staff was successfully destroyed"
  end
end
