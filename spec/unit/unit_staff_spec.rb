require 'rails_helper'

RSpec.describe Staff, type: :model do
    subject do
        described_class.new(
            is_admin: false,
            first_name: 'John',
            last_name: 'Doe',
            phone_number: '123-456-7890',
            email: 'john.doe@tamu.edu',
            password: 'jdoe123.'
        )
    end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without first name' do
    subject.first_name = nil
    expect(subject).not_to be_valid
  end

  it 'is not valid without last name' do
    subject.last_name = nil
    expect(subject).not_to be_valid
  end

  it 'is not valid without phone number' do
    subject.phone_number = nil
    expect(subject).not_to be_valid
  end

  it 'is not valid without email' do
    subject.email = nil
    expect(subject).not_to be_valid
  end

  it 'is not valid without password' do
    subject.password = nil
    expect(subject).not_to be_valid
  end

  it 'can be updated' do
    subject.update(:is_admin => true)
    subject.update(:first_name => 'Jane')
    subject.update(:last_name => 'Deer')
    subject.update(:phone_number => '987-654-3210')
    subject.update(:email => 'jane.deer@tamu.edu')
    subject.update(:password => 'jdeer321!')
    expect(Staff.find_by_is_admin(true)).to eq(subject)
    expect(Staff.find_by_first_name('Jane')).to eq(subject)
    expect(Staff.find_by_last_name('Deer')).to eq(subject)
    expect(Staff.find_by_phone_number('987-654-3210')).to eq(subject)
    expect(Staff.find_by_email('jane.deer@tamu.edu')).to eq(subject)
    expect(Staff.find_by_password('jdeer321!')).to eq(subject)
  end

  it 'can be deleted' do
    subject.destroy
    expect(Staff.find_by_first_name('Jane')).to be_nil
  end
end
