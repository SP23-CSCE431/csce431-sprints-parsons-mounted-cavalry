class PagesController < ApplicationController
  before_action :set_dates
  def set_dates
    if (params[:day].present?)
      @curr_day = Date.parse(params[:day])
    end
    @curr_day ||= Date.today
    @start_day = @curr_day.beginning_of_month
    @end_day = @curr_day.end_of_month
  end

  # path for cadets to check in
  def checkin_cadets; end

  # path for staff to check in
  def checkin_staffs; end

  # path for reports for admins
  def reports_admins
    @horses = Horse.all
    @cadets = User.where(is_staff: false, is_admin: false)
    @staffs = User.where(is_staff: true, is_admin: false)
  end

  # path for reports for staff
  def reports_staffs 
    @horses = Horse.all
    @cadets = User.where(is_staff: false, is_admin: false)
    @staffs = User.where(is_staff: true, is_admin: false)
  end
end
