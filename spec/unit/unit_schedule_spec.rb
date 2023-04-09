require 'rails_helper'

RSpec.describe Schedule, type: :model do
  # create instances of reference that are used in creation of schedule
  subject do
    described_class.new(user_id: user.id, recurrence: ['M', 'W', 'F'])
  end

  describe 'create' do
    it 'is valid' do
      expect(subject).to be_valid
    end

    it 'has no user' do
      schedule = Schedule.new(recurrence: ['M', 'W', 'F'])
      expect(schedule).to_not be_valid
    end

    it 'has no recurrence' do
      schedule = Schedule.new(user_id: user.id)
      expect(schedule).to_not be_valid
    end

    it 'user already has schedule' do
      Schedule.create(user_id: user.id, recurrence: ['M', 'W', 'F'])
      expect(Schedule.new(user_id: user.id, recurrence: ['T', 'R'])).to_not be_valid
    end
  end

  describe 'update' do
    it 'valid schedule change' do
      subject.update(:recurrence => ['T', 'R'])
      expect(Schedule.find_by_recurrence(['T', 'R'])).to(eq(subject))
    end

    it 'update with nil recurrence' do
      subject.update(:recurrence => nil)
      expect(subject).not_to(be_valid)
    end
  end

  describe 'delete' do
    it 'schedule can be deleted' do
      subject.destroy
      expect(Schedule.find_by_recurrence(['T', 'R'])).to(be_nil)
    end
  end
end
