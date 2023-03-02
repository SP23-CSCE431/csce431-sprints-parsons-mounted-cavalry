class Attendance < ApplicationRecord
    validates :schedule_id, presence: true
    belongs_to :schedule
    belongs_to :horse
end
