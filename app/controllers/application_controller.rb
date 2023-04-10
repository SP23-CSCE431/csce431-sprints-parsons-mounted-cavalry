class ApplicationController < ActionController::Base
    include Devise::Controllers::Helpers
    include Pundit::Authorization
    before_action :authenticate_admin!
    before_action :set_report_type_cookie

    rescue_from Pundit::NotAuthorizedError, with: :pundishing_user

    private

    # defines logged in user for permission rules
    def pundit_user
        User.where(:email => current_admin.email).first
    end

    # notification for incorrect authorization
    def pundishing_user
        flash[:alert] = "You are not authorized to perform this action."
        redirect_to root_path
    end

    # sets the default report type cookie
    def set_report_type_cookie
        cookies[:report_type] ||= 'horse'
    end
end
  