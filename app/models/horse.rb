class Horse < ApplicationRecord
    validates :name, :condition,  presence: true
    validates :brand, uniqueness: true, presence: true
    validates :herd, inclusion: { in: %w[Alpha Bravo Charlie Delta Injured OOS] }, presence: true
    validates :difficulty, inclusion: { in: %w[Easy Intermediate Advanced] }, presence: true

    has_many :attendances, dependent: :destroy
end
