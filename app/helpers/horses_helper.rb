module HorsesHelper
    # get the current user's role and return proper path for that role
    def horses_get_user_path(user)
        if user.is_admin
            return admins_horses_path
        elsif user.is_staff
            return staffs_horses_path
        else
            return cadets_horses_path
        end
    end
end
