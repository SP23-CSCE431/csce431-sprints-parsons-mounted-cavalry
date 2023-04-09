class AttendancesController < ApplicationController
  before_action :set_attendance, only: %i[ show edit update destroy ]

  # GET /attendances or /attendances.json
  def index
    @attendances = Attendance.all
    authorize @attendances
  end

  # gets attendances (none) for cadet path
  def cadets
  end

  # gets all attendances for staff path
  def staffs
    @attendances = Attendance.all
    authorize @attendances
  end

  # gets all attendances for admin path
  def admins
    @attendances = Attendance.all
    authorize @attendances
  end

  # GET /attendances/1 or /attendances/1.json
  def show
  end

  # GET /attendances/new
  def new
    @attendance = Attendance.new(schedule_id: params[:schedule_id], date: params[:date])
    authorize @attendance
  end

  # GET /attendances/1/edit
  def edit
  end

  # POST /attendances or /attendances.json
  def create
    @attendance = Attendance.new(attendance_params)
    authorize @attendance
    respond_to do |format|
      if @attendance.save
        format.html { redirect_to(admins_schedules_url, notice: "Attendance was successfully created.") }
        format.json { render(:show, status: :created, location: @attendance) }
      else
        format.html { render(:new, status: :unprocessable_entity) }
        format.json { render(json: @attendance.errors, status: :unprocessable_entity) }
      end
    end
  end

  # PATCH/PUT /attendances/1 or /attendances/1.json
  def update
    authorize @attendance
    respond_to do |format|
      if @attendance.update(attendance_params)
        format.html { redirect_to(admins_schedules_url, notice: "Attendance was successfully updated.") }
        format.json { render(:show, status: :ok, location: @attendance) }
      else
        format.html { render(:edit, status: :unprocessable_entity) }
        format.json { render(json: @attendance.errors, status: :unprocessable_entity) }
      end
    end
  end

  # routes user to confirmation page to delete attendance
  def delete
    @attendance = Attendance.find(params[:id])
    authorize @attendance
  end

  # DELETE /attendances/1 or /attendances/1.json
  def destroy
    authorize @attendance
    @attendance.destroy
    respond_to do |format|
      format.html { redirect_to(admins_schedules_url, notice: "Attendance was successfully destroyed.") }
      format.json { head(:no_content) }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_attendance
      @attendance = Attendance.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def attendance_params
      params.require(:attendance).permit(:schedule_id, :horse_id, :date, :check_in_time, :purpose)
    end
end
