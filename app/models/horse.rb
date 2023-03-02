class Horse < ApplicationRecord
    validates :name, :condition,  presence: true
    validates :brand, uniqueness: true, presence: true
    validates :herd, inclusion: { in: ['Alpha', 'Bravo', 'Charlie', 'Delta', 'OOS']}, presence: true
    validates :difficulty, inclusion: { in: ['Easy', 'Intermediate', 'Advanced']}, presence: true
end
