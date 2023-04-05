class ApplicationController < ActionController::Base
    include Devise::Controllers::Helpers
    include Pundit::Authorization
    before_action :authenticate_admin!
    
    
    rescue_from Pundit::NotAuthorizedError, with: :pundishing_user

    private
        def pundit_user
            User.where(:email => current_admin.email).first
        end
        def pundishing_user
            flash[:notice] = "You are not authorized to perform this action."
            redirect_to root_path
        end
end
