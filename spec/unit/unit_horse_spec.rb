require 'rails_helper'

RSpec.describe Horse, type: :model do
    subject do
        described_class.new(name: "Horse", brand: 'H1199', birthday: '01/01/1999')
    end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is valid that horse can be updated' do
    subject.update(:name => "Horse1")
    subject.update(:brand => "H1198")
    subject.update(:birthday => "01/02/1999")
    expect(Horse.find_by_name("Horse1")).to eq(subject)
    expect(Horse.find_by_brand("H1198")).to eq(subject)
    expect(Horse.find_by_birthday("01/02/1999")).to eq(subject)
  end

  it 'is valid that horse can be deleted' do
    subject.destroy
    expect(Horse.find_by_name("Horse1")).to be_nil
  end
  
  it 'is not valid without a name' do
    subject.name = nil
    expect(subject).not_to be_valid
  end
  
  it 'is not valid without a brand' do
    subject.brand = nil
    expect(subject).not_to be_valid
  end
  
  it 'is not valid without a birthday' do
    subject.birthday = nil
    expect(subject).not_to be_valid
  end

end