class SchedulesController < ApplicationController
  before_action :set_schedule, only: %i[show edit update destroy]
  before_action :set_dates
  before_action :get_user, only: %i[ create update destroy ]

  def get_user
    @user = User.where(:email => current_admin.email).first
  end

  # checks to see if the week has been changed
  # if so, adjust the dates to the correct week dates
  # if not, use the current cookie date
  def set_dates
    if (params[:week].present?)
      @curr_day = Date.parse(params[:week])
    else
      @curr_day = Date.parse(cookies[:schedule_date])
    end
    cookies[:schedule_date] = @curr_day.strftime
    @range = helpers.week_range(@curr_day)
    @dates = helpers.week_dates(@curr_day)
  end

  # GET /schedules or /schedules.json
  def index
    @schedules = Schedule.all
    authorize @schedules
  end

  # gets schedules (none) for cadets path
  def cadets; end

  # gets all schedules for staffs path
  def staffs
    @schedules = Schedule.all
    authorize @schedules
  end

  # gets all schedules for admins path
  def admins
    @schedules = Schedule.all
    authorize @schedules
  end

  # GET /schedules/1 or /schedules/1.json
  def show; end

  # GET /schedules/new
  def new
    @schedule = Schedule.new(user_id: params[:user_id])
    authorize @schedule
  end

  # GET /schedules/1/edit
  def edit; end

  # POST /schedules or /schedules.json
  def create
    @schedule = Schedule.new(schedule_params)
    authorize @schedule
    respond_to do |format|
      if @schedule.save
        format.html { redirect_to(helpers.schedules_get_user_path(@user), notice: "Schedule was successfully created.") }
        format.json { render(:show, status: :created, location: @schedule) }
      else
        format.html { render(:new, status: :unprocessable_entity) }
        format.json { render(json: @schedule.errors, status: :unprocessable_entity) }
      end
    end
  end

  # PATCH/PUT /schedules/1 or /schedules/1.json
  def update
    authorize @schedule
    respond_to do |format|
      user_id = schedule_params[:user_id]
      recurrence = schedule_params[:recurrence]

      # in order to make sure if recurrence changed to blank, it is validated correctly 
      if recurrence.nil?
        recurrence = []
      end 

      if @schedule.update(:user_id => user_id, :recurrence => recurrence)
        format.html { redirect_to(helpers.schedules_get_user_path(@user), notice: "Schedule was successfully updated.") }
        format.json { render(:show, status: :ok, location: @schedule) }
      else
        format.html { render(:edit, status: :unprocessable_entity) }
        format.json { render(json: @schedule.errors, status: :unprocessable_entity) }
      end
    end
  end

  # routes user to confirmation page to delete schedule
  def delete
    @schedule = Schedule.find(params[:id])
    authorize @schedule
  end

  # DELETE /schedules/1 or /schedules/1.json
  def destroy
    authorize @schedule
    @schedule.destroy!

    respond_to do |format|
      format.html { redirect_to(helpers.schedules_get_user_path(@user), notice: "Schedule was successfully destroyed.") }
      format.json { head(:no_content) }
    end
  end

    private

  # Use callbacks to share common setup or constraints between actions.
  def set_schedule
    @schedule = Schedule.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def schedule_params
    params.require(:schedule).permit(:user_id, :recurrence => [])
  end
end
