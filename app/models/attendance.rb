class Attendance < ApplicationRecord
    validates :appointment_time, :check_in_time, :check_out_time, :purpose, presence: true
    # belongs_to :horse
    # belongs_to :cadet
    # belongs_to :staff
end
