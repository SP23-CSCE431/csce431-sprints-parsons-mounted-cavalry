# frozen_string_literal: true

class ReportsComponent < ViewComponent::Base
    def initialize(horses, cadets, staffs, start_day, end_day, curr_day)
        super @horses = horses
        super @cadets = cadets
        super @staffs = staffs
        super @start_day = start_day
        super @end_day = end_day
        super @curr_day = curr_day
    end
end
