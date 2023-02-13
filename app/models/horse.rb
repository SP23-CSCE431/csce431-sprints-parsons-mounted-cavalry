class Horse < ApplicationRecord
    validates :name,:brand, :birthday,  presence: true
end
