module UsersHelper
    # get the current user's role and return proper path for that role
    def users_get_user_path(user)
        if user.is_admin
            admins_users_url
        elsif user.is_staff
            staffs_users_url
        else
            cadets_users_url
        end
    end
end
