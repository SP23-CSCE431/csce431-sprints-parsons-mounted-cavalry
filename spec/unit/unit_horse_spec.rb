require 'rails_helper'

RSpec.describe Horse, type: :model do
    subject do
        described_class.new(name: 'Horse', brand: 'H1199',  herd: 'Alpha', difficulty: 'Easy', condition: 'Healthy')
    end
    #these tests are designed to validate the creation of horse and ensuring the correct inputs
    describe 'create' do
        describe 'name creation' do
            it 'has valid name' do
                expect(subject).to be_valid
            end
            it 'has nil name' do
                horse = Horse.new(brand: 'H1192', difficulty: 'hi', herd: 'Alpha', condition: 'Healthy')
                expect(horse).not_to be_valid
            end
            it 'has empty name' do
                horse = Horse.new(name: '', brand: 'H1192', difficulty: 'hi', herd: 'Alpha', condition: 'Healthy')
                expect(horse).not_to be_valid
            end
        end
        describe 'brand creation' do
            it 'has unique brand' do
                horse = Horse.new(name: 'hi', brand: 'H1192', difficulty: 'Easy', herd: 'Alpha', condition: 'Healthy')
                expect(horse).to be_valid
            end
            it 'has nil brand' do
                horse = Horse.new(name: 'hi', difficulty: 'Easy', herd: 'Alpha', condition: 'Healthy')
                expect(horse).not_to be_valid
            end
            it 'has empty brand' do
                horse = Horse.new(name: 'hi', brand: '', difficulty: 'Easy', herd: 'Alpha', condition: 'Healthy')
                expect(horse).not_to be_valid
            end
        end
        describe 'herd creation' do
            it 'has valid herd' do
                expect(subject).to be_valid
            end
            it 'has invalid herd' do
                horse = Horse.new(name: 'hi', brand: 'H1192', difficulty: 'Easy', herd: 'hi', condition: 'Healthy')
                expect(horse).not_to be_valid
            end
            it 'has nil herd' do
                horse = Horse.new(name: 'hi', brand: 'H1192', difficulty: 'Easy', condition: 'Healthy')
                expect(horse).not_to be_valid
            end
            it 'has empty herd' do
                horse = Horse.new(name: 'hi', brand: 'H1192', difficulty: 'Easy', herd: '', condition: 'Healthy')
                expect(horse).not_to be_valid
            end
        end
        describe 'difficulty creation' do
            it 'has valid difficulty' do
                expect(subject).to be_valid
            end
            it 'has invalid difficulty' do
                horse = Horse.new(name: 'hi', brand: 'H1192', difficulty: '01', herd: 'Alpha', condition: 'Healthy')
                expect(horse).not_to be_valid
            end
            it 'has nil difficulty' do
                horse = Horse.new(name: 'hi', brand: 'H1192', herd: 'Alpha', condition: 'Healthy')
                expect(horse).not_to be_valid
            end
            it 'has empty difficulty' do
                horse = Horse.new(name: 'hi', brand: 'H1192', difficulty: '', herd: 'Alpha', condition: 'Healthy')
                expect(horse).not_to be_valid
            end
        end
        describe 'condition creation' do
            it 'has valid condition' do
                expect(subject).to be_valid
            end
            it 'has nil condition' do
                horse = Horse.new(name: 'hi', brand: 'H1192', herd: 'Alpha')
                expect(horse).not_to be_valid
            end
            it 'has empty condition' do
                horse = Horse.new(name: 'hi', brand: 'H1192', difficulty: '', herd: 'Alpha', condition: '')
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
        describe 'difficulty updated' do
            it 'valid difficulty is updated' do
                subject.update(:difficulty => 'Intermediate')
                expect(Horse.find_by_difficulty('Intermediate')).to eq(subject)
            end
            it 'tried to update with invalid difficulty' do
                subject.update(:difficulty => '01')
                expect(subject).not_to be_valid 
            end
            it 'tried to update with empty difficulty' do
                subject.update(:difficulty => '')
                expect(subject).not_to be_valid 
            end
            it 'tried to update with nil difficulty' do
                subject.update(:difficulty => nil)
                expect(subject).not_to be_valid 
            end
        end
        describe 'herd updated' do
            it 'valid herd is updated' do
                subject.update(:herd => 'Delta')
                expect(Horse.find_by_herd('Delta')).to eq(subject)
            end
            it 'tried to update with invalid herd' do
                subject.update(:herd=> 'hi')
                expect(subject).not_to be_valid 
            end
            it 'tried to update with empty herd' do
                subject.update(:herd => '')
                expect(subject).not_to be_valid 
            end
            it 'tried to update with nil herd' do
                subject.update(:herd => nil)
                expect(subject).not_to be_valid 
            end
        end
        describe 'condition updated' do
            it 'valid condition is updated' do
                subject.update(:condition => 'Injured')
                expect(Horse.find_by_condition('Injured')).to eq(subject)
            end
            it 'tried to update with empty condition' do
                subject.update(:condition => '')
                expect(subject).not_to be_valid 
            end
            it 'tried to update with nil condition' do
                subject.update(:condition => nil)
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
