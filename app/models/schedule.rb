class Schedule < ApplicationRecord
    validates :user_id, presence: true
    validate :at_least_one_day_selected
  
    belongs_to :user
    has_many :attendances, dependent: :destroy
  
    attribute :monday, :boolean, default: false
    attribute :tuesday, :boolean, default: false
    attribute :wednesday, :boolean, default: false
    attribute :thursday, :boolean, default: false
    attribute :friday, :boolean, default: false
  
    def recurrence
      days = ''
      days += 'M' if monday
      days += 'T' if tuesday
      days += 'W' if wednesday
      days += 'R' if thursday
      days += 'F' if friday
      days
    end
  
    private
  
    def at_least_one_day_selected
      errors.add(:base, 'Please select at least one day') unless monday || tuesday || wednesday || thursday || friday
    end
  end
  