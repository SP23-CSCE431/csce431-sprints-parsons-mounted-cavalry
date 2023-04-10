# frozen_string_literal: true

class HorseReportComponent < ViewComponent::Base
    def initialize(horses, start_day, end_day, curr_day)
        super @horses = horses
        super @start_day = start_day
        super @end_day = end_day
        super @curr_day = curr_day
    end

    # maps the given horse's difficulty level to a color, returns the color
    def get_horse_difficulty_color(horse)
        colors = { 'Easy' => '#a7f1a8', 'Intermediate' => '#FFF36D', 'Advanced' => '#f47174' }

        if horse.nil?
            'none'
        else
            colors[horse.difficulty]
        end
    end

    # maps the given horse's difficulty level to a color, returns the color
    def get_horse_herd_color(horse)
        colors = { 'Alpha' => '#FFF36D', 'Bravo' => '#A7F1A8', 'Charlie' => '#83A0EE', 'Delta' => '#8B6C5C', 'OOS' => '#F47174' }

        if horse.nil?
            'none'
        else
            colors[horse.herd]
        end
    end

    # gets the number of days a certain horse was used
    def get_num_days_horse_used(horse)
        # Get the attendances where the date is within the specified month, with the specified horse, that was actually attended 
        Attendance.where(:date => @start_day..@end_day, :horse_id => horse.id).where.not(:check_in_time => nil).length()
    end
end
