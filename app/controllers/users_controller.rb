class UsersController < ApplicationController
    include Devise::Controllers::Helpers
    before_action :set_user, only: %i[show edit update destroy]
    before_action :curr_user, only: %i[create update destroy]

    # get the currently signed in user
    def curr_user
      @curr_user = User.where(:email => current_admin.email).first
    end

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
      @cadets = User.where(is_staff: false, is_admin: false).where.not(classification: 'OOS')
    end

    # filters out users whose role is command staff and cadet
    def staffs
      @staffs = User.where(is_staff: true, is_admin: false).where.not(classification: 'OOS')
      @cadets = User.where(is_staff: false, is_admin: false).where.not(classification: 'OOS')
      @oos = User.where(classification: 'OOS')
      authorize pundit_user
    end

    # filters out users whose role is admin, command staff, and cadet
    def admins
      @admins = User.where(is_admin: true).where.not(classification: 'OOS')
      @staffs = User.where(is_staff: true, is_admin: false).where.not(classification: 'OOS')
      @staffs += @admins
      @cadets = User.where(is_staff: false, is_admin: false).where.not(classification: 'OOS')
      @oos = User.where(classification: 'OOS')
      authorize pundit_user
    end

    # GET /users/1 or /users/1.json
    def show; end

    # GET /users/new
    def new
      @user = User.new
      authorize @user
    end

    # GET /users/1/edit
    def edit
      @user = User.find(params[:id])
    end

    # POST /users or /users.json
    def create
      @user = User.new(user_params)

      authorize @user
      case params[:user][:role]
      when "Cadet"
        @user.is_staff = false
        @user.is_admin = false
      when "Command Staff"
        @user.is_staff = true
        @user.is_admin = false
      when "Admin"
        @user.is_admin = true
        @user.is_staff = false
      end
      respond_to do |format|
        if @user.save
          flash[:success] = "#{@user.first_name} #{@user.last_name} was successfully created."
          format.html { redirect_to(helpers.users_get_user_path(@curr_user)) }
          format.json { render(:show, status: :created, location: @user) }
        else
          format.html { render(:new, status: :unprocessable_entity) }
          format.json { render(json: @user.errors, status: :unprocessable_entity) }
        end
      end
    end

    # PATCH/PUT /users/1 or /users/1.json
    def update
      authorize @user
      case params[:user][:role]
      when "Cadet"
        @user.is_staff = false
        @user.is_admin = false
      when "Command Staff"
        @user.is_staff = true
        @user.is_admin = false
      when "Admin"
        @user.is_admin = true
        @user.is_staff = false
      end
      respond_to do |format|
        if @user.update(user_params)
          flash[:success] = "#{@user.first_name} #{@user.last_name} was successfully updated."
          format.html { redirect_to(helpers.users_get_user_path(@curr_user)) }
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
      authorize @user
    end

    # DELETE /users/1 or /users/1.json
    def destroy
      # schedules = Schedule.where(user_id: @user.id)
      # schedules do |schedule|
      authorize @user
      @user.destroy!

      respond_to do |format|
        format.html do
 redirect_to(helpers.users_get_user_path(@curr_user), alert: "#{@user.first_name} #{@user.last_name} was successfully deleted.")
        end
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
