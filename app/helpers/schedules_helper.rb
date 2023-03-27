module SchedulesHelper
    # for every existing user, map the their full name to their id
    # return the pair for form dropdown purposes
    def users_full_name
        users = User.all
        u = {}
        users.each do |user|
            user_full_name = "#{user.first_name} #{user.last_name}"
            save_in_db = user.id
            u.store(user_full_name, save_in_db)
        end
        u
    end
end
