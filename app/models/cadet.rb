class Cadet < ApplicationRecord

    validates :first_name, :last_name, :graduation_year, :phone_number, :uin,
    presence: true, allow_blank: false
    
end
