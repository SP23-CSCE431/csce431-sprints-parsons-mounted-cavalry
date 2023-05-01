class Admins::SessionsController < Devise::SessionsController
    # after sign out, redirect to login page
    def after_sign_out_path_for(_resource_or_scope)
        new_admin_session_path
    end

    # after sign in, redirect to appropriate path
    def after_sign_in_path_for(_resource_or_scope)
        if pundit_user.is_admin
            admins_schedules_path
        elsif pundit_user.is_staff
            staffs_schedules_path
        else
            checkin_cadets_pages_path
        end
    end
end
