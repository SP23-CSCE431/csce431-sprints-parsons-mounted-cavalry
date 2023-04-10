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
  def checkin_cadets
    user1 = User.where(:email => current_admin.email).first
    @attendance = Attendance.where(:date => @curr_day).first
    authorize pundit_user
  end

  # path for staff to check in
  def checkin_staffs
    authorize pundit_user
  end

  # path for reports for admins
  def reports_admins
    @horses = Horse.all
    @cadets = User.where(is_staff: false, is_admin: false)
    @staffs = User.where(is_staff: true, is_admin: false)
    authorize pundit_user
  end

  # path for reports for staff
  def reports_staffs
    @horses = Horse.all
    @cadets = User.where(is_staff: false, is_admin: false)
    @staffs = User.where(is_staff: true, is_admin: false)
    authorize pundit_user
  end
end
