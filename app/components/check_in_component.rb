# frozen_string_literal: true

class CheckInComponent < ViewComponent::Base
    def initialize(attendance)
        super @attendance = attendance
    end

      # given a horse id, returns the horse
    def get_horse(horse_id)
        Horse.where(id: horse_id).first
    end

    # given an attendance object, if no check in time, red, if check in time, green
    def get_checkin_time_color(attendance)
        colors = { 'CheckedIn' => '#A7F1A8', 'NotCheckedIn' => '#F47174' }

        if attendance&.check_in_time.nil?
            colors['NotCheckedIn']
        else 
            colors['CheckedIn']
        end
    end
end
