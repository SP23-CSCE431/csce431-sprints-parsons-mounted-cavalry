require 'rails_helper'

RSpec.describe User, type: :model do
    subject do
        described_class.new(first_name: 'Billy', last_name: 'Bob', classification: 'Junior',  skill_level: 'Intermediate', phone_number: '8229852917', email: 'billybob@tamu.edu', is_staff: 'false', is_admin: 'false')
    end
    #these tests are designed to validate the creation of a user and ensure the correct inputs
    describe 'create' do
        describe 'name creation' do
            it 'has valid first and last name' do
                expect(subject).to be_valid
            end
            it 'has nil first name' do
                user = User.new(last_name: 'Bob', classification: 'Junior',  skill_level: 'Intermediate', phone_number: '8229852917', email: 'billybob@tamu.edu', is_staff: 'false', is_admin: 'false')
                expect(user).not_to be_valid
            end
            it 'has empty first name' do
                user = User.new(first_name: '', last_name: 'Bob', classification: 'Junior',  skill_level: 'Intermediate', phone_number: '8229852917', email: 'billybob@tamu.edu', is_staff: 'false', is_admin: 'false')
                expect(user).not_to be_valid
            end
        end
        describe 'classification creation' do
            it 'has valid classification' do
                expect(subject).to be_valid
            end
            it 'has invalid classification' do
                user = User.new(first_name: 'Billy', last_name: 'Bob', classification: 'InvalidClass',  skill_level: 'Intermediate', phone_number: '8229852917', email: 'billybob@tamu.edu', is_staff: 'false', is_admin: 'false')
                expect(user).not_to be_valid
            end
            it 'has nil classification' do
                user = User.new(first_name: 'Billy', last_name: 'Bob', skill_level: 'Intermediate', phone_number: '8229852917', email: 'billybob@tamu.edu', is_staff: 'false', is_admin: 'false')
                expect(user).not_to be_valid
            end
            it 'has empty classification' do
                user = User.new(first_name: 'Billy', last_name: 'Bob', classification: '',  skill_level: 'Intermediate', phone_number: '8229852917', email: 'billybob@tamu.edu', is_staff: 'false', is_admin: 'false')
                expect(user).not_to be_valid
            end
        end
        describe 'skill level creation' do
            it 'has valid skill level' do

            end
            it 'has invalid skill level' do
                user = User.new(first_name: 'Billy', last_name: 'Bob', classification: 'Junior',  skill_level: 'InvalidSkillLevel', phone_number: '8229852917', email: 'billybob@tamu.edu', is_staff: 'false', is_admin: 'false')
                expect(user).not_to be_valid
            end
            it 'has nil skill level' do
                user = User.new(first_name: 'Billy', last_name: 'Bob', classification: 'Junior', phone_number: '8229852917', email: 'billybob@tamu.edu', is_staff: 'false', is_admin: 'false')
                expect(user).not_to be_valid
            end
            it 'has empty skill level' do
                user = User.new(first_name: 'Billy', last_name: 'Bob', classification: 'Junior',  skill_level: '', phone_number: '8229852917', email: 'billybob@tamu.edu', is_staff: 'false', is_admin: 'false')
                expect(user).not_to be_valid
            end
        end
        describe 'phone number creation' do
            it 'has valid phone number' do
                expect(subject).to be_valid
            end
            it 'has invalid phone number' do
                user = User.new(first_name: 'Billy', last_name: 'Bob', classification: 'Junior',  skill_level: 'Intermediate', phone_number: '1234567', email: 'billybob@tamu.edu', is_staff: 'false', is_admin: 'false')
                expect(user).not_to be_valid
            end
            it 'has nil phone number' do
                user = User.new(first_name: 'Billy', last_name: 'Bob', classification: 'Junior',  skill_level: 'Intermediate', email: 'billybob@tamu.edu', is_staff: 'false', is_admin: 'false')
                expect(user).not_to be_valid
            end
            it 'has empty phone number' do
                user = User.new(first_name: 'Billy', last_name: 'Bob', classification: 'Junior',  skill_level: 'Intermediate', phone_number: '', email: 'billybob@tamu.edu', is_staff: 'false', is_admin: 'false')
                expect(user).not_to be_valid
            end
        end
        describe 'email creation' do
            it 'has valid email' do
                expect(subject).to be_valid
            end
            it 'has invalid email' do
                user = User.new(first_name: 'Billy', last_name: 'Bob', classification: 'Junior',  skill_level: 'Intermediate', phone_number: '8229852917', email: 'billybob@gmail.com', is_staff: 'false', is_admin: 'false')
                expect(user).not_to be_valid
            end
            it 'has nil email' do
                user = User.new(first_name: 'Billy', last_name: 'Bob', classification: 'Junior',  skill_level: 'Intermediate', phone_number: '8229852917', is_staff: 'false', is_admin: 'false')
                expect(user).not_to be_valid
            end
            it 'has empty email' do
                user = User.new(first_name: 'Billy', last_name: 'Bob', classification: 'Junior',  skill_level: 'Intermediate', phone_number: '8229852917', email: '', is_staff: 'false', is_admin: 'false')
                expect(user).not_to be_valid
            end
        end
    end
    
    #these tests are to validate if updating a user is within valid specifications
    describe 'update' do
        describe 'name updated' do
            it 'valid name is updated' do
                subject.update(:first_name => 'Billy1')
                expect(User.find_by_first_name('Billy1')).to eq(subject)      
            end
            it 'tried to update with empty name' do
                subject.update(:first_name => '')
                expect(subject).not_to be_valid 
            end
            it 'tried to update with nil name' do
                subject.update(:first_name => nil)
                expect(subject).not_to be_valid 
            end
        end
        describe 'classification updated' do
            it 'valid classification is updated' do
                subject.update(:classification => 'Senior')
                expect(User.find_by_classification('Senior')).to eq(subject)
            end
            it 'tried to update with invalid classification' do
                subject.update(:classification => 'InvalidClass')
                expect(subject).not_to be_valid 
            end
            it 'tried to update with empty classification' do
                subject.update(:classification => '')
                expect(subject).not_to be_valid 
            end
            it 'tried to update with nil classification' do
                subject.update(:classification => nil)
                expect(subject).not_to be_valid 
            end
        end
        describe 'skill_level updated' do
            it 'valid skill_level is updated' do
                subject.update(:skill_level => 'Advanced')
                expect(User.find_by_skill_level('Advanced')).to eq(subject)
            end
            it 'tried to update with invalid skill_level' do
                subject.update(:skill_level => 'InvalidSkillLevel')
                expect(subject).not_to be_valid 
            end
            it 'tried to update with empty skill_level' do
                subject.update(:skill_level => '')
                expect(subject).not_to be_valid 
            end
            it 'tried to update with nil skill_level' do
                subject.update(:skill_level => nil)
                expect(subject).not_to be_valid 
            end
        end
        describe 'phone_number updated' do
            it 'valid phone_number is updated' do
                subject.update(:phone_number => '8332324164')
                expect(User.find_by_phone_number('8332324164')).to eq(subject)
            end
            it 'tried to update with invalid phone_number' do
                subject.update(:phone_number=> '123123')
                expect(subject).not_to be_valid 
            end
            it 'tried to update with empty phone_number' do
                subject.update(:phone_number => '')
                expect(subject).not_to be_valid 
            end
            it 'tried to update with nil phone_number' do
                subject.update(:phone_number => nil)
                expect(subject).not_to be_valid 
            end
        end
        describe 'email updated' do
            it 'valid email is updated' do
                subject.update(:email => 'billy1bob@tamu.edu')
                expect(User.find_by_email('billy1bob@tamu.edu')).to eq(subject)
            end
            it 'tried to update with invalid email' do
                subject.update(:email=> 'billy1bob@gmail.com')
                expect(subject).not_to be_valid 
            end
            it 'tried to update with empty condition' do
                subject.update(:email => '')
                expect(subject).not_to be_valid 
            end
            it 'tried to update with nil condition' do
                subject.update(:email => nil)
                expect(subject).not_to be_valid 
            end
        end
    end

    describe 'delete' do
        it 'user can be deleted' do
            subject.destroy
            expect(User.find_by_first_name('Billy')).to be_nil
        end
    end
end

