# frozen_string_literal: true

class CadetReportsComponent < ViewComponent::Base
    def initialize(cadets, staffs, start_day, end_day, curr_day)
        super @cadets = cadets
        super @staffs = staffs
        super @start_day = start_day
        super @end_day = end_day
        super @curr_day = curr_day
    end

    # Given a user, returns an integer of the user's total attendances within the specified month
    def get_user_total_attendance(user)
        Attendance.joins(:schedule).where('schedules.user_id = ? AND date >= ? AND date <= ?', user.id, @start_day, @end_day).count
    end

    # Given a user, returns an integer of the user's total absences within the specified month
    def get_user_absences(user)
        Attendance.joins(:schedule).where('schedules.user_id = ? AND date >= ? AND date <= ? AND check_in_time IS NULL', user.id, @start_day, @end_day).count
    end

    # Given a user, returns an integer of the user's total "Work & Ride" attendances within the specified month
    def get_user_work_and_ride(user)
        Attendance.joins(:schedule).where('schedules.user_id = ? AND date >= ? AND date <= ? AND purpose = ?', user.id, @start_day, @end_day, 'Ride & Work').count
    end

    # Given a user, returns an integer of the user's total "Work" attendances within the specified month
    def get_user_work(user)
        Attendance.joins(:schedule).where('schedules.user_id = ? AND date >= ? AND date <= ? AND purpose = ?', user.id, @start_day, @end_day, 'Work').count
    end

    # Given a user, returns an integer of the user's total "Ride" attendances within the specified month
    def get_user_ride(user)
        Attendance.joins(:schedule).where('schedules.user_id = ? AND date >= ? AND date <= ? AND purpose = ?', user.id, @start_day, @end_day, 'Ride').count
    end

    # Given a user, returns an integer of the user's total "Sections" attendances within the specified month
    def get_user_sections(user)
        Attendance.joins(:schedule).where('schedules.user_id = ? AND date >= ? AND date <= ? AND purpose = ?', user.id, @start_day, @end_day, 'Sections').count
    end

    # Given a user, returns an integer of the user's total "Training" attendances within the specified month
    def get_user_training(user)
        Attendance.joins(:schedule).where('schedules.user_id = ? AND date >= ? AND date <= ? AND purpose = ?', user.id, @start_day, @end_day, 'Training').count
    end
end
