require 'rails_helper'

RSpec.describe Attendance, type: :model do
  before(:all) do
    @attendance = Attendance.create(attendance_id: 1, cadet_id: 1, horse_id: 1, staff_id: 1, appointment_time: Time.now, check_in_time: Time.now, check_out_time: Time.now, purpose: "Test")
  end

  it 'is valid with valid attributes' do
    expect(@attendance).to be_valid
  end

  it 'is valid that attendance can be updated' do
    @attendance.update(:purpose => "Test Update")
    expect(Attendance.find_by_purpose("Test Update")).to eq(@attendance)
  end

  it 'is that an attendance can be destroyed' do
    @attendance.destroy
    expect(Attendance.find_by_purpose("Test Update")).to be_nil
  end

  it 'is not valid without a purpose' do
    subject.purpose = nil
    expect(subject).not_to be_valid
  end
end
