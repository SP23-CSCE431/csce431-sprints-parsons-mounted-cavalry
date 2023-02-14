class Staff < ApplicationRecord
    validates :first_name, :last_name, :phone_number, :email, :password, presence: true
end
