module AttendancesHelper
    # get the current user's role and return proper path for that role
    def attendances_get_user_path(user)
        if user.is_admin
            return admins_schedules_url
        elsif user.is_staff
            return staffs_schedules_url
        else
            return cadets_schedules_url
        end
    end

    # given a schedule id, return the user's name
    def user_by_schedule_id(schedule_id)
        schedule = Schedule.where(id: schedule_id).first
        if schedule
            user = User.where(id: schedule.user_id).first
            "#{user.first_name} #{user.last_name}" if user
        end
    end

    # converts the given date to a nicely formatted string
    def format_date(date)
        Date.parse(date.to_s).strftime('%A, %B %-d, %Y')
    end

    # maps horse ids to their name + brand to allow for easier form selection
    def horses_info
        horses = Horse.where.not(herd: 'OOS')
        h = {}  
        h.store('None', nil)
        horses.each do |horse|
            horse_info = "#{horse.name} - #{horse.brand} (#{horse.difficulty})"
            save_in_db = horse.id
            h.store(horse_info, save_in_db)
        end
        h
    end
end
