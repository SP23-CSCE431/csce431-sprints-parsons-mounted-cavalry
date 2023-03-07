class Schedule < ApplicationRecord
    validates :recurrence, presence: true

    belongs_to :user
    has_many :attendances, dependent: :destroy
end
