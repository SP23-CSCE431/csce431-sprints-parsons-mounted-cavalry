class Attendance < ApplicationRecord
    validates :schedule_id, :date, presence: true
    validates :purpose, inclusion: { in: ['Ride', 'Work', 'Ride & Work', 'Training', 'Sections', 'No']}, presence: true
    #validates :horse_id, presence: true, allow_nil: true

    validate :horse_id_nil_or_exists

    def horse_id_nil_or_exists
        if (Horse.find_by_id(self.horse_id) == nil && self.horse_id != nil)
            errors.add(:horse_id, 'Horse must exist')
        end
    end


    belongs_to :schedule
    belongs_to :horse, optional: true
end
