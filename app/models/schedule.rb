class Schedule < ApplicationRecord
    validates :user_id, uniqueness: { :message => 'already has schedule' }
    serialize :recurrence
    validates :recurrence, presence: true

    belongs_to :user

    has_many :attendances, dependent: :destroy
end
