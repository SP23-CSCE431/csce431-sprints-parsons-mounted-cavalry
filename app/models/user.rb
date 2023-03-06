class User < ApplicationRecord

    has_many :schedules, dependent: :destroy

    validates :first_name, :last_name, :email, presence: true, allow_nil: false, allow_blank: false

    validates :classification, inclusion: { in: ['Sophmore', 'Junior', 'Senior']}, presence: true

    validates :skill_level, inclusion: { in: ['Beginner', 'Intermediate', 'Advanced']}, presence: true

    # Accepts valid US emails. If more countries wanted, change settings in config/initializers/phonelib.rb
    validates :phone_number, presence: true, allow_nil: false, allow_blank: false, phone: true

    # Regex format means that only accepts @tamu.edu emails
    validates :email,
        format: { with: /\A[a-zA-Z0-9_.+-]+@tamu\.edu\z/, message: "Must be a tamu email"}

end
