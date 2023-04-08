class Schedule < ApplicationRecord
    validates_uniqueness_of :user_id, :message => 'already has schedule'
    serialize :recurrence
    validates :recurrence, presence: true

    belongs_to :user
    
    has_many :attendances, dependent: :destroy
end
