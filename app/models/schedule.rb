class Schedule < ApplicationRecord
    validates :user_id, :recurrence, presence: true

    belongs_to :user
end
