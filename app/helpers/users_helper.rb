module UsersHelper
    # get the current user's role and return proper path for that role
    def users_get_user_path(user)
        if user.is_admin
            return admins_users_url
        elsif user.is_staff
            return staffs_users_url
        else
            return cadets_users_url
        end
    end
end
