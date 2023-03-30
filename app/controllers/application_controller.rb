class ApplicationController < ActionController::Base
    include Devise::Controllers::Helpers
    before_action :authenticate_admin!
end
