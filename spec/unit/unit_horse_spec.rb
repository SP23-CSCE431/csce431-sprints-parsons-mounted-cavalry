require 'rails_helper'

RSpec.describe Horse, type: :model do
    before(:all) do
        @horse = Horse.create(name: "Horse", brand: 'H1199', birthday: '01/01/1999')
    end

  it 'is valid with valid attributes' do
    expect(@horse).to be_valid
  end

  it 'is valid that horse can be updated' do
    @horse.update(:name => "Horse1")
    expect(Horse.find_by_name("Horse1")).to eq(@horse)
  end

  it 'is that a horse can be destroyed' do
    @horse.destroy
    expect(Horse.find_by_name("Horse1")).to be_nil
  end

  it 'is not valid without a name' do
    subject.name = nil
    expect(subject).not_to be_valid
  end
end