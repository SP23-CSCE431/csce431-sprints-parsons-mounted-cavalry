class Admins::OmniauthCallbacksController < Devise::OmniauthCallbacksController
    # gets email, name, uid, and avatar from google
    # flashes notification to notify whether user logged in
    def google_oauth2
        admin = Admin.from_google(**from_google_params)

        if admin.present?
            sign_out_all_scopes
            flash[:success] = t('devise.omniauth_callbacks.success', kind: 'Google')
            sign_in_and_redirect(admin, event: :authentication)
        else
            flash[:notice] = t('devise.omniauth_callbacks.failure', kind: 'Google', reason: "#{auth.info.email} is not authorized.")
            redirect_to(new_admin_session_path)
        end
    end

    protected

    # if login fails, redirects to login page
    def after_omniauth_failure_path_for(_scope)
        new_admin_session_path
    end

    # if login successful, redirects current user to appropriate path
    def after_sign_in_path_for(_resource_or_scope)
        if pundit_user.is_admin
            admins_schedules_path
        elsif pundit_user.is_staff
            staffs_schedules_path
        else
            checkin_cadets_pages_path
        end
    end

    private

    # params: uid, email, name, avatar
    def from_google_params
        @from_google_params ||= { uid: auth.uid, email: auth.info.email, full_name: auth.info.name, avatar_url: auth.info.image }
    end

    def auth
        @auth ||= request.env['omniauth.auth']
    end
end
