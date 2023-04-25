# frozen_string_literal: true

class UsageCounterComponent < ViewComponent::Base
    # takes in a range of dates
    def initialize(dates)
        super
        @start_day = dates.first
        @end_day = dates.last

        @horses_sorted = horse_num_days(Horse.where.not(herd: 'OOS'))
        @cadets_sorted = cadet_num_days(User.where.not(is_admin: true).where.not(classification: 'OOS'))
    end

    # takes in a list of horses, returns sorted array of hashes relating horse and attendance count
    def horse_num_days(horses)
        horse_attendances = []

        # for each horse get # attendances and store in hash; push hash to array
        horses.each do |horse|
            num_attendances = Attendance.where(:date => @start_day..@end_day, :horse_id => horse.id).length
            horse_attendance = { :horse => horse, :num_attendances => num_attendances }
            horse_attendances.push(horse_attendance)
        end

        # sort in decending order based on attendance count
        horse_attendances.sort_by { |horse_attendance| horse_attendance[:num_attendances] }
                         .reverse
    end

    # takes in a list of cadets, returns sorted array of hashes relating cadet and attendance count
    def cadet_num_days(cadets)
        cadet_attendances = []

        # for each cadet get # attendances and store in hash; push hash to array
        cadets.each do |cadet|
            # don't include cadets who don't have schedules
            schedule = Schedule.where(user_id: cadet.id).first
            next unless schedule

            num_attendances = Attendance.where(:date => @start_day..@end_day, :schedule_id => schedule.id).length
            cadet_attendance = { :cadet => cadet, :num_attendances => num_attendances }
            cadet_attendances.push(cadet_attendance)
        end

        # sort in decending order based on attendance count
        cadet_attendances.sort_by { |cadet_attendance| cadet_attendance[:num_attendances] }
                         .reverse
    end

    # maps the given horse's difficulty level to a color, returns the color
    def get_horse_difficulty_color(horse)
        colors = { 'Easy' => '#a7f1a8', 'Intermediate' => '#fff36d', 'Advanced' => '#f47174' }

        if horse.nil?
            'none'
        else
            colors[horse.difficulty]
        end
    end

    # maps the given user's skill level to a color, returns the color
    def get_user_skill_level_color(user)
        colors = { 'Beginner' => '#a7f1a8', 'Intermediate' => '#fff36d', 'Advanced' => '#f47174' }
        colors[user.skill_level]
    end
end
