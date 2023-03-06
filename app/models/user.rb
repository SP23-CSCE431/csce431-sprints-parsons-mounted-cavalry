class User < ApplicationRecord
    has_many :schedules, dependent: :destroy

    validates :first_name, :last_name, :phone_number, :email, presence: true

    # validates :email,
    #     format: { with: /^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@tamu.edu$}, message: "Email invalid"
end
