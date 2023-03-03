class Attendance < ApplicationRecord
    validates :schedule_id, :date, presence: true
    validates :purpose, inclusion: { in: ['Ride', 'Work', 'Ride & Work', 'Training', 'Sections', 'No']}, presence: true

    belongs_to :schedule
    belongs_to :horse
end
