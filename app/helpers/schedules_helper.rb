module SchedulesHelper
    def get_users_full_name
        users = User.all
        u = {}
        users.each do |user|
            user_full_name = user.first_name + " " + user.last_name
            save_in_db = user.id
            u.store(user_full_name, save_in_db)
        end
        u
    end
end
