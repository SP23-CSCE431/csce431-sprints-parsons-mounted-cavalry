class Horse < ApplicationRecord
    validates :name, :birthday,  presence: true
    validates :brand, uniqueness: true, presence: true
end
