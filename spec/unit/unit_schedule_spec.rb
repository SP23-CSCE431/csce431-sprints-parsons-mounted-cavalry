require 'rails_helper'

RSpec.describe Schedule, type: :model do
  # create instances of reference that are used in creation of schedule
  subject do
    described_class.new(user_id: user.id, recurrence: %w[M W F])
  end

  let(:user) { User.create(is_admin: true, is_staff: true, first_name: 'John', last_name: 'Doe', classification: 'Senior', skill_level: 'Advanced', phone_number: '8229852917', email: 'j.doe@tamu.edu') }

  describe 'create' do
    it 'is valid' do
      expect(subject).to be_valid
    end

    it 'has no user' do
      schedule = Schedule.new(recurrence: %w[M W F])
      expect(schedule).not_to be_valid
    end

    it 'has no recurrence' do
      schedule = Schedule.new(user_id: user.id)
      expect(schedule).not_to be_valid
    end

    it 'user already has schedule' do
      Schedule.create(user_id: user.id, recurrence: %w[M W F])
      expect(Schedule.new(user_id: user.id, recurrence: %w[T R])).not_to be_valid
    end
  end

  describe 'update' do
    it 'valid schedule change' do
      subject.update(:recurrence => %w[T R])
      expect(Schedule.find_by_recurrence(%w[T R])).to(eq(subject))
    end

    it 'update with nil recurrence' do
      subject.update(:recurrence => nil)
      expect(subject).not_to(be_valid)
    end
  end

  describe 'delete' do
    it 'schedule can be deleted' do
      subject.destroy
      expect(Schedule.find_by_recurrence(%w[T R])).to(be_nil)
    end
  end
end
