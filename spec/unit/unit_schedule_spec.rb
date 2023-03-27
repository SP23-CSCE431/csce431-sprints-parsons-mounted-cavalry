require 'rails_helper'

RSpec.describe Schedule, type: :model do
  # create instances of reference that are used in creation of schedule 
  let(:user) { User.create(is_admin: true, is_staff: true, first_name: 'John', last_name: 'Doe', classification: 'Senior', skill_level: 'Advanced', phone_number: '8229852917', email: 'j.doe@tamu.edu') }

  subject do
    described_class.new(user_id: user.id, recurrence: 'MWF')
  end

  it "is valid with valid attributes" do
    schedule = Schedule.new(user_id: user.id, recurrence: 'MWF')
    expect(schedule).to be_valid
  end

  it "is not valid without a user_id" do
    schedule = Schedule.new(recurrence: 'MWF')
    expect(schedule).to_not be_valid
  end

  it "is not valid without a recurrence" do
    schedule = Schedule.new(user_id: user.id)
    expect(schedule).to_not be_valid
  end

  it "belongs to a user" do
    schedule = Schedule.new(user_id: user.id, recurrence: 'MWF')
    expect(schedule).to respond_to(:user)
  end

  it "has many attendances" do
    schedule = Schedule.new(user_id: user.id, recurrence: 'MWF')
    expect(schedule).to respond_to(:attendances)
  end
end
