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
  # Gets the current user's schedules and takes their attendance for the current day, if there is any
  def checkin_cadets
    user1 = User.where(:email => current_admin.email).first
    schedule = Schedule.where(:user_id => user1.id).first
    @attendance = Attendance.where(:date => @curr_day.strftime, schedule_id: schedule&.id).first
    authorize pundit_user
  end

  # Skip before action is here because of errors with the ajax request
  skip_before_action :verify_authenticity_token, only: [:checkedin_cadets, :checkedin_staffs]
  # path for cadets after checking in
  # Gets the attendance from the patch ajax request, updates the check in time to the current time, and then returns to the checkin cadets page
  def checkedin_cadets
    @attendance = Attendance.find(params[:id])
    respond_to do |format|
      if @attendance.update(:check_in_time => Time.now)
        format.html { redirect_to(checkin_cadets_pages_path, status: :see_other, notice: "You have been checked in.") }
        format.json { render(:show, status: :ok, location: @attendance) }
      else
        format.html { render(:edit, status: :unprocessable_entity) }
        format.json { render(json: @attendance.errors, status: :unprocessable_entity) }
      end
    end
  end

  # path for cadets to check in
  # Gets the current user's schedules and takes their attendance for the current day, if there is any
  def checkin_staffs
    user1 = User.where(:email => current_admin.email).first
    schedule = Schedule.where(:user_id => user1.id).first
    @attendance = Attendance.where(:date => @curr_day.strftime, schedule_id: schedule&.id).first
    authorize pundit_user
  end

  # path for cadets after checking in
  # Gets the attendance from the patch ajax request, updates the check in time to the current time, and then returns to the checkin cadets page
  def checkedin_staffs
    @attendance = Attendance.find(params[:id])
    respond_to do |format|
      if @attendance.update(:check_in_time => Time.now)
        format.html { redirect_to(checkin_cadets_pages_path, status: :see_other, notice: "You have been checked in.") }
        format.json { render(:show, status: :ok, location: @attendance) }
      else
        format.html { render(:edit, status: :unprocessable_entity) }
        format.json { render(json: @attendance.errors, status: :unprocessable_entity) }
      end
    end
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

  private

  # Only allow a list of trusted parameters through.
  def attendance_params
    params.require(:attendance).permit(:schedule_id, :horse_id, :date, :check_in_time, :purpose)
  end
end
