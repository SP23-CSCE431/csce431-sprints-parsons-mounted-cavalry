module AttendancesHelper
    # given a schedule id, return the user's name
    def get_user_by_schedule_id(schedule_id)
        schedule = Schedule.where(:id => schedule_id).first
        if (schedule)
            user = User.where(:id => schedule.user_id).first
            if (user)
                return user.first_name + ' ' + user.last_name
            else
                return nil
            end
        else
            return nil
        end
    end

    # converts the given date to a nicely formatted string
    def format_date(date)
        date_test = Date.parse(date.to_s).strftime('%A, %B %-d, %Y')
        return date_test
    end

    # maps schedule ids to a user's name to allow for easier form selection
    def get_users_by_schedule_id
        schedules = Schedule.all
        s = {}
        schedules.each do |schedule|
            user = User.find(schedule.user_id)
            user_full_name = user.first_name + " " + user.last_name
            save_in_db = schedule.id
            s.store(user_full_name, save_in_db)
        end
        s
    end

    # maps horse ids to their name + brand to allow for easier form selection
    def get_horses_info
        horses = Horse.all
        h = {}
        h.store('None', nil)
        horses.each do |horse|
            horse_info = horse.name + ' - ' + horse.brand + ' (' + horse.difficulty + ')'
            save_in_db = horse.id
            h.store(horse_info, save_in_db)
        end
        h
    end
end
