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
    Rails.logger.info("log sched: #{schedule&.id}")
    @attendance = Attendance.where(:date => @curr_day.strftime, schedule_id: schedule&.id).first
    Rails.logger.info("log att: #{@attendance&.id} #{@attendance&.check_in_time}")
    authorize pundit_user
  end

  # Skip before action is here because of errors with the ajax request
  skip_before_action :verify_authenticity_token, only: [:checkedin]
  # path for cadets after checking in
  # Gets the attendance from the patch ajax request, updates the check in time to the current time, and then returns to the checkin cadets page
  def checkedin
    @attendance = Attendance.find(params[:id])
    Rails.logger.info("log att: #{@attendance&.id} #{@attendance&.check_in_time}")
    respond_to do |format|
      if @attendance.update(:check_in_time => Time.now)
        Rails.logger.info("checked in updated")
        format.html { redirect_to(cadets_schedules_url, status: :see_other, notice: "You have been checked in.") }
        format.json { render(:show, status: :ok, location: @attendance) }
      else
        format.html { render(:edit, status: :unprocessable_entity) }
        format.json { render(json: @attendance.errors, status: :unprocessable_entity) }
      end
    end
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

  private

  # Only allow a list of trusted parameters through.
  def attendance_params
    params.require(:attendance).permit(:schedule_id, :horse_id, :date, :check_in_time, :purpose)
  end
end
