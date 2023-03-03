class Attendance < ApplicationRecord
    validates :schedule_id, :date, :purpose, presence: true

    has_many :schedules
    has_many :horses
end
