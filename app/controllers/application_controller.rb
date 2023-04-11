class ApplicationController < ActionController::Base
    include Devise::Controllers::Helpers
    include Pundit::Authorization
    before_action :authenticate_admin!

    rescue_from Pundit::NotAuthorizedError, with: :pundishing_user

    private

    # defines logged in user for permission rules
    def pundit_user
        User.where(:email => current_admin.email).first
    end

    # notification for incorrect authorization
    def pundishing_user
        flash[:notice] = "You are not authorized to perform this action."
        redirect_to root_path
    end

    def set_schedule_date_cookie
        cookies[:schedule_date] ||= (Date.today + 1).strftime
    end
end
