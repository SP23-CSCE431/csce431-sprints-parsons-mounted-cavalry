class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]

  # GET /users or /users.json
  def index
    @users = User.all
  end

  def cadets
    @cadets = User.where(is_staff: false, is_admin: false)
  end

  def staffs
    @staffs = User.where(is_staff: true)
    @cadets = User.where(is_staff: false, is_admin: false)
  end

  def admins
    @admins = User.where(is_admin: true)
    @staffs = User.where(is_staff: true)
    @cadets = User.where(is_staff: false, is_admin: false)
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to users_url, notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to users_url, notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def delete
    @user = User.find(params[:id])
  end 

  # DELETE /users/1 or /users/1.json
  def destroy
    #schedules = Schedule.where(user_id: @user.id)
    #schedules do |schedule|


    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
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