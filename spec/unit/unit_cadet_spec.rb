require 'rails_helper'

RSpec.describe Cadet, type: :model do
  subject do
    described_class.new(first_name: 'Billy', last_name: 'Bob', graduation_year: '2024', phone_number: '0123456789', uin: '120003456')
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without a first name' do
    subject.first_name = nil
    expect(subject).not_to be_valid
  end

  it 'is not valid without a last name' do
    subject.last_name = nil
    expect(subject).not_to be_valid
  end

  it 'is not valid without a graduation year' do
    subject.graduation_year = nil
    expect(subject).not_to be_valid
  end

  it 'is not valid without a phone number' do
    subject.phone_number = nil
    expect(subject).not_to be_valid
  end

  it 'is not valid without a uin' do
    subject.uin = nil
    expect(subject).not_to be_valid
  end
end