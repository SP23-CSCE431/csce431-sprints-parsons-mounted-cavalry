class UsersController < ApplicationController
    include Devise::Controllers::Helpers
  before_action :set_user, only: %i[show edit update destroy]

  # GET /users or /users.json
  def index
    @users = User.all
    user1 = User.where(:email => current_admin.email).first
    if signed_in?
        if user1.is_admin?
            redirect_to(admins_schedules_path)
        elsif user1.is_staff?
            redirect_to(staffs_schedules_path)
        else
            redirect_to(checkin_cadets_pages_path)
        end
    end
  end

  # filters out users whose role is cadet
  def cadets
    @cadets = User.where(is_staff: false, is_admin: false)
  end

  # filters out users whose role is command staff and cadet
  def staffs
    @staffs = User.where(is_staff: true, is_admin: false)
    @cadets = User.where(is_staff: false, is_admin: false)
  end

  # filters out users whose role is admin, command staff, and cadet
  def admins
    @admins = User.where(is_admin: true)
    @staffs = User.where(is_staff: true, is_admin: false)
    @staffs += @admins
    @cadets = User.where(is_staff: false, is_admin: false)
  end

  # GET /users/1 or /users/1.json
  def show; end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit; end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to(admins_users_url, notice: "#{@user.first_name} #{@user.last_name} was successfully created.") }
        format.json { render(:show, status: :created, location: @user) }
      else
        format.html { render(:new, status: :unprocessable_entity) }
        format.json { render(json: @user.errors, status: :unprocessable_entity) }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to(admins_users_url, notice: "#{@user.first_name} #{@user.last_name} was successfully updated.") }
        format.json { render(:show, status: :ok, location: @user) }
      else
        format.html { render(:edit, status: :unprocessable_entity) }
        format.json { render(json: @user.errors, status: :unprocessable_entity) }
      end
    end
  end

  # routes user to confirmation page to delete user
  def delete
    @user = User.find(params[:id])
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    # schedules = Schedule.where(user_id: @user.id)
    # schedules do |schedule|

    @user.destroy!

    respond_to do |format|
      format.html { redirect_to(admins_users_url, notice: "#{@user.first_name} #{@user.last_name} was successfully destroyed.") }
      format.json { head(:no_content) }
    end
  end

    private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:is_admin, :is_staff, :first_name, :last_name, :classification, :skill_level, :phone_number, :email)
  end
end
