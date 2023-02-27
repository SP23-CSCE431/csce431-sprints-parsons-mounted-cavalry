require 'rails_helper'

RSpec.describe Horse, type: :model do
    subject do
        described_class.new(name: 'Horse', brand: 'H1199', birthday: '01/01/1999')
    end
    #these tests are designed to validate the creation of horse and ensuring the correct inputs
    describe 'create' do
        describe 'name creation' do
            it 'has valid name' do
                expect(subject).to be_valid
            end
            it 'has nil name' do
                horse = Horse.new(brand: 'H1199', birthday: 'hi')
                expect(horse).not_to be_valid
            end
            it 'has empty name' do
                horse = Horse.new(name: '', brand: 'H1199', birthday: 'hi')
                expect(horse).not_to be_valid
            end
        end
        describe 'brand creation' do
            it 'has unique brand' do
                horse = Horse.new(name: 'hi', brand: 'H1192', birthday: '01/01/1999')
                expect(horse).to be_valid
            end
            it 'has nil brand' do
                horse = Horse.new(name: 'hi', birthday: '01/01/1999')
                expect(horse).not_to be_valid
            end
            it 'has empty brand' do
                horse = Horse.new(name: 'hi', brand: '', birthday: '01/01/1999')
                expect(horse).not_to be_valid
            end
        end
        describe 'birthday creation' do
            it 'has valid birthday' do
                expect(subject).to be_valid
            end
            it 'has invalid birthday' do
                horse = Horse.new(name: 'hi', brand: 'H1199', birthday: '01')
                expect(horse).not_to be_valid
            end
            it 'has nil birthday' do
                horse = Horse.new(name: 'hi', brand: 'H1199')
                expect(horse).not_to be_valid
            end
            it 'has empty birthday' do
                horse = Horse.new(name: 'hi', brand: 'H1199', birthday: '')
                expect(horse).not_to be_valid
            end
        end
    end
    
    #these tests are to validate if updating a horse is within valid specifications
    describe 'update' do
        describe 'name updated' do
            it 'valid name is updated' do
                subject.update(:name => 'Horse1')
                expect(Horse.find_by_name('Horse1')).to eq(subject)      
            end
            it 'tried to update with empty name' do
                subject.update(:name => '')
                expect(subject).not_to be_valid 
            end
            it 'tried to update with nil name' do
                subject.update(:name => nil)
                expect(subject).not_to be_valid 
            end
        end
        describe 'brand updated' do
            it 'valid brand is updated' do
                subject.update(:brand => 'H1198')
                expect(Horse.find_by_brand('H1198')).to eq(subject)
            end
            it 'tried to update with empty brand' do
                subject.update(:brand => '')
                expect(subject).not_to be_valid 
            end
            it 'tried to update with nil brand' do
                subject.update(:brand => nil)
                expect(subject).not_to be_valid 
            end
        end
        describe 'birthday updated' do
            it 'valid birthday is updated' do
                subject.update(:birthday => '01/02/1999')
                expect(Horse.find_by_birthday('01/02/1999')).to eq(subject)
            end
            it 'tried to update with empty birthday' do
                subject.update(:birthday => '')
                expect(subject).not_to be_valid 
            end
            it 'tried to update with nil birthday' do
                subject.update(:birthday => nil)
                expect(subject).not_to be_valid 
            end
        end
    end

    describe 'delete' do
        it 'horse can be deleted' do
            subject.destroy
            expect(Horse.find_by_name('Horse1')).to be_nil
        end
    end
end
