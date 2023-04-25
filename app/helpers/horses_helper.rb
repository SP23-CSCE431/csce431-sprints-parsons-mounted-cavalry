module HorsesHelper
    # get the current user's role and return proper path for that role
    def horses_get_user_path(user)
        if user.is_admin
            admins_horses_path
        elsif user.is_staff
            staffs_horses_path
        else
            cadets_horses_path
        end
    end
end
