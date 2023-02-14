require 'rails_helper'

RSpec.describe Cadet, type: :model do
  subject do
    described_class.new(first_name: 'Billy', last_name: 'Bob', graduation_year: '2024', phone_number: '0123456789', uin: '120003456')
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is valid that cadet can be updated' do
    subject.update(:first_name => "Billy2")
    subject.update(:last_name => "Bob2")
    subject.update(:graduation_year => "2025")
    subject.update(:phone_number => "9876543210")
    subject.update(:uin => "654300021")
    expect(Cadet.find_by_first_name("Billy2")).to eq(subject)
    expect(Cadet.find_by_last_name("Bob2")).to eq(subject)
    expect(Cadet.find_by_graduation_year("2025")).to eq(subject)
    expect(Cadet.find_by_phone_number("9876543210")).to eq(subject)
    expect(Cadet.find_by_uin("654300021")).to eq(subject)
  end

  it 'is valid that cadet can be deleted' do
    subject.destroy
    expect(Cadet.find_by_first_name("Billy2")).to be_nil
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