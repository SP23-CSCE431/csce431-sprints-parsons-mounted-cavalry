class Attendance < ApplicationRecord
    validates :date, presence: true
    validates :purpose, inclusion: { in: ['Ride', 'Work', 'Ride & Work', 'Training', 'Sections', 'No'] }, presence: true
    
    validates_uniqueness_of :horse_id, :scope => :date, :message => 'already scheduled for this date'
    validates_uniqueness_of :schedule_id, :scope => :date, :message => 'already has this user for this date'

    validate :horse_id_nil_or_exists

    # checks if the horse id is nil or it exists
    # if not, it cannot be validated
    def horse_id_nil_or_exists
        errors.add(:horse_id, 'Horse must exist') if Horse.find_by(id: horse_id).nil? && !horse_id.nil?
    end

    belongs_to :schedule
    belongs_to :horse, optional: true
end
