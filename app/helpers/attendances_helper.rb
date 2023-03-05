module AttendancesHelper
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

    def get_horses_info
        horses = Horse.all
        h = {}
        h.store("None", nil)
        horses.each do |horse|
            horse_info = horse.name + " - " + horse.brand
            save_in_db = horse.id
            h.store(horse_info, save_in_db)
        end
        h
    end
end
