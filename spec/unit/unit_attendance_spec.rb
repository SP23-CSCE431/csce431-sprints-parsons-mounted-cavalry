require 'rails_helper'

RSpec.describe Attendance, type: :model do
    subject do
        described_class.new(attendance_id: 1, cadet_id: 1, horse_id: 1, staff_id: 1, appointment_time: '01/01/2023', check_in_time: '01/01/2023', check_out_time: '01/01/2023', purpose: "Riding Lesson")
    end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is valid that attendance can be updated' do
    subject.update(:attendance_id => 2)
    subject.update(:cadet_id => 2)
    subject.update(:horse_id => 2)
    subject.update(:staff_id => 2)
    subject.update(:appointment_time => '01/02/2023')
    subject.update(:check_in_time => '01/02/2023')
    subject.update(:check_out_time => '01/02/2023')
    subject.update(:purpose => "Feeding")
    expect(Attendance.find_by_attendance_id(2)).to eq(subject)
    expect(Attendance.find_by_cadet_id(2)).to eq(subject)
    expect(Attendance.find_by_horse_id(2)).to eq(subject)
    expect(Attendance.find_by_staff_id(2)).to eq(subject)
    expect(Attendance.find_by_appointment_time('01/02/2023')).to eq(subject)
    expect(Attendance.find_by_check_in_time('01/02/2023')).to eq(subject)
    expect(Attendance.find_by_check_out_time('01/02/2023')).to eq(subject)
    expect(Attendance.find_by_purpose("Feeding")).to eq(subject)
  end

  it 'is valid that attendance can be destroyed' do
    subject.destroy
    expect(Attendance.find_by_attendance_id(2)).to be_nil
  end
  
  # it 'is not valid without a attendance_id' do
  #   subject.attendance_id = nil
  #   expect(subject).not_to be_valid
  # end
  
  # it 'is not valid without a cadet_id' do
  #   subject.cadet_id = nil
  #   expect(subject).not_to be_valid
  # end
  
  # it 'is not valid without a horse_id' do
  #   subject.horse_id = nil
  #   expect(subject).not_to be_valid
  # end
  
  # it 'is not valid without a staff_id' do
  #   subject.staff_id = nil
  #   expect(subject).not_to be_valid
  # end
  
  it 'is not valid without a appointment_time' do
    subject.appointment_time = nil
    expect(subject).not_to be_valid
  end

  it 'is not valid without an appointment_time' do
    subject.appointment_time = nil
    expect(subject).not_to be_valid
  end
    
  it 'is not valid without a check_in_time' do
    subject.check_in_time = nil
    expect(subject).not_to be_valid
  end
    
  it 'is not valid without a check_out_time' do
    subject.check_out_time = nil
    expect(subject).not_to be_valid
  end
    
  it 'is not valid without a purpose' do
    subject.purpose = nil
    expect(subject).not_to be_valid
  end
end
