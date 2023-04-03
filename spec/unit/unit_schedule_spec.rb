require 'rails_helper'

RSpec.describe Schedule, type: :model do
  # create instances of reference that are used in creation of schedule 
  let(:user) { User.create(is_admin: true, is_staff: true, first_name: 'John', last_name: 'Doe', classification: 'Senior', skill_level: 'Advanced', phone_number: '8229852917', email: 'j.doe@tamu.edu') }

  subject do
    described_class.new(user_id: user.id, recurrence: 'MWF')
  end

  describe 'create' do
    it 'is valid' do
      expect(subject).to be_valid
    end

    it 'has no user' do
      schedule = Schedule.new(recurrence: 'MWF')
      expect(schedule).to_not be_valid
    end

    it 'has no recurrence' do
      schedule = Schedule.new(user_id: user.id)
      expect(schedule).to_not be_valid
    end

    it 'user already has schedule' do
      Schedule.create(user_id: user.id, recurrence: 'MWF')
      expect(Schedule.new(user_id: user.id, recurrence: 'TR')).to_not be_valid
    end
  end

  describe 'update' do
    it 'valid schedule change' do
      subject.update(:recurrence => 'TR')
      expect(Schedule.find_by_recurrence('TR')).to(eq(subject))
    end

    it 'update with nil recurrence' do
      subject.update(:recurrence => nil)
      expect(subject).not_to(be_valid)
    end
  end

  describe 'delete' do
    it 'schedule can be deleted' do
      subject.destroy
      expect(Schedule.find_by_recurrence('TR')).to(be_nil)
    end
  end
end
