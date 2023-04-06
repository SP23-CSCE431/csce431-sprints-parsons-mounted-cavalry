class PagesController < ApplicationController
  # path for cadets to check in
  def checkin_cadets
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
