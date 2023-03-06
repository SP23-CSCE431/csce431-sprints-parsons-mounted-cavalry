require 'rails_helper'

RSpec.describe Attendance, type: :model do
  # create instances of reference that are used in creation of attendances 
  let(:user) { User.create(is_admin: true, is_staff: true, first_name: 'John', last_name: 'Doe', classification: 'Senior', skill_level: 'Advanced', phone_number: '8229852917', email: 'j.doe@tamu.edu') }
  let(:schedule) { Schedule.create(user_id: user.id, recurrence: 'MWF') }
  let(:horse) { Horse.create(name: 'Ed', brand: 'B12', herd: 'Charlie', difficulty: 'Intermediate', condition: 'Healthy') }

  # sunny day case
  subject do
    described_class.new(schedule_id: schedule.id, horse_id: horse.id, date: '2023-12-25', check_in_time: nil, purpose: 'Training')
  end

  # validate creation of attendances
  describe 'create' do
    describe 'schedule selection' do
      it 'has valid schedule' do
        expect(subject).to be_valid
      end
      it 'has no schedule' do
        attendance = Attendance.new(horse_id: horse.id, date: '2023-12-25', check_in_time: nil, purpose: 'Training')
        expect(attendance).not_to be_valid
      end
      it 'has nil schedule' do 
        attendance = Attendance.new(schedule_id: nil, horse_id: horse.id, date: '2023-12-25', check_in_time: nil, purpose: 'Training')
        expect(attendance).not_to be_valid
      end
      it 'has invalid/non-existent schedule' do
        attendance = Attendance.new(schedule_id: -1, horse_id: horse.id, date: '2023-12-25', check_in_time: nil, purpose: 'Training')
        expect(attendance).not_to be_valid
      end
    end
    describe 'horse selection' do
      it 'has valid horse' do
        expect(subject).to be_valid
      end
      it 'has no horse is okay' do
        attendance = Attendance.new(schedule_id: schedule.id, date: '2023-12-25', check_in_time: nil, purpose: 'Training')
        expect(attendance).to be_valid
      end
      it 'has nil horse is okay' do 
        attendance = Attendance.new(schedule_id: schedule.id, horse_id: nil, date: '2023-12-25', check_in_time: nil, purpose: 'Training')
        expect(attendance).to be_valid
      end
      it 'has invalid/non-existent horse' do
        attendance = Attendance.new(schedule_id: schedule.id, horse_id: -1, date: '2023-12-25', check_in_time: nil, purpose: 'Training')
        expect(attendance).not_to be_valid
      end
    end
    describe 'date selection' do
      it 'has valid date' do
        expect(subject).to be_valid
      end
      it 'has invalid day' do
        attendance = Attendance.new(schedule_id: schedule.id, horse_id: horse.id, date: '2023-12-32', check_in_time: nil, purpose: 'Training')
        expect(attendance).not_to be_valid
      end
      it 'has invalid month' do
        attendance = Attendance.new(schedule_id: schedule.id, horse_id: horse.id, date: '2023-13-25', check_in_time: nil, purpose: 'Training')
        expect(attendance).not_to be_valid
      end
      it 'has nil date' do
        attendance = Attendance.new(schedule_id: schedule.id, horse_id: horse.id, date: nil, check_in_time: nil, purpose: 'Training')
        expect(attendance).not_to be_valid
      end
      it 'has empty date' do
        attendance = Attendance.new(schedule_id: schedule.id, horse_id: horse.id, date: '', check_in_time: nil, purpose: 'Training')
        expect(attendance).not_to be_valid
      end
    end
    describe 'check in time selection' do
      it 'is not initially instantiated' do
        expect(subject).to be_valid
      end
    end
    describe 'purpose selection' do
      it 'has valid purpose' do
        expect(subject).to be_valid
      end
      it 'has invalid purpose' do
        attendance = Attendance.new(schedule_id: schedule.id, horse_id: horse.id, date: '2023-12-25', check_in_time: nil, purpose: 'Running')
        expect(attendance).not_to be_valid
      end
      it 'has nil purpose' do
        attendance = Attendance.new(schedule_id: schedule.id, horse_id: horse.id, date: '2023-12-25', check_in_time: nil, purpose: nil)
        expect(attendance).not_to be_valid
      end
      it 'has empty purpose' do
        attendance = Attendance.new(schedule_id: schedule.id, horse_id: horse.id, date: '2023-12-25', check_in_time: nil, purpose: '')
        expect(attendance).not_to be_valid
      end
    end
  end

  # validate updating of attendances
  describe 'update' do
    describe 'schedule change' do
      it 'valid schedule change' do
        new_user = User.create(is_admin: true, is_staff: true, first_name: 'John', last_name: 'Doe', classification: 'Senior', skill_level: 'Advanced', phone_number: '8229852917', email: 'j.doe@tamu.edu')
        new_schedule = Schedule.create(user_id: new_user.id, recurrence: 'MWF')
        subject.update(:schedule_id => new_schedule.id)
        expect(Attendance.find_by_schedule_id(new_schedule.id)).to eq(subject)
      end
      it 'update with nil schedule' do
        subject.update(:schedule_id => nil)
        expect(subject).not_to be_valid
      end
      it 'update with invalid/non-existent schedule' do
        subject.update(:schedule_id => -1)
        expect(subject).not_to be_valid
      end
    end
    describe 'horse change' do
      it 'valid horse change' do
        new_horse = Horse.create(name: 'Ed', brand: 'B12', herd: 'Charlie', difficulty: 'Intermediate', condition: 'Healthy')
        subject.update(:horse_id => new_horse.id)
        expect(Attendance.find_by_horse_id(new_horse.id)).to eq(subject)
      end
      it 'update with nil horse is okay' do
        subject.update(:horse_id => nil)
        expect(Attendance.find_by_horse_id(nil)).to eq(subject)
      end
      it 'update with invalid/non-existent horse' do
        subject.update(:horse_id => -1)
        expect(subject).not_to be_valid
      end
    end
    describe 'date change' do
      it 'valid date change' do
        subject.update(:date => '2024-07-03')
        expect(Attendance.find_by_date('2024-07-03')).to eq(subject)
      end
      it 'update with empty date' do
        subject.update(:date => '')
        expect(subject).not_to be_valid
      end
      it 'update with nil date' do
        subject.update(:date => nil)
        expect(subject).not_to be_valid
      end
      it 'update with invalid day' do
        subject.update(:date => '2023-12-32')
        expect(subject).not_to be_valid
      end
      it 'update with invalid month' do
        subject.update(:date => '2023-13-25')
        expect(subject).not_to be_valid
      end
    end
    describe 'check in time change' do
      it 'valid check in time change' do
        time = Time.now
        subject.update(:check_in_time => time)
        expect(Attendance.find_by_check_in_time(time)).to eq(subject)
      end
    end
    describe 'purpose change' do
      it 'valid purpose change' do
        subject.update(:purpose => 'Work')
        expect(Attendance.find_by_purpose('Work')).to eq(subject)
      end
      it 'update with empty purpose' do
        subject.update(:purpose => '')
        expect(subject).not_to be_valid
      end
      it 'update with nil purpose' do
        subject.update(:purpose => nil)
        expect(subject).not_to be_valid
      end
      it 'update with invalid purpose' do
        subject.update(:purpose => 'Running')
        expect(subject).not_to be_valid
      end
    end
  end

  # validate deletion of attendances
  describe 'delete' do
    it 'attendance can be deleted' do
      expect(subject).to be_valid
      subject_id = subject.id
      subject.destroy
      expect(Attendance.find_by_id(subject_id)).to be_nil
    end
  end
end
