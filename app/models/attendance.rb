class Attendance < ApplicationRecord
    validates :schedule_id, :date, :purpose, presence: true

    belongs_to :schedule
    belongs_to :horse
end
