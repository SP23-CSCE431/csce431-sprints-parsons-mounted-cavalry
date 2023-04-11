class HorsesController < ApplicationController
    before_action :set_horse, only: %i[ show edit update destroy ]
    before_action :get_user, only: %i[ create update destroy ]

    def get_user
        @user = User.where(:email => current_admin.email).first
    end

    # GET /horses or /horses.json
    def index
        @horses = Horse.all
        authorize @horses
    end

    def cadets
    end
  
    def staffs
        @horses = Horse.where.not(herd: 'OOS')
        @oos = Horse.where(herd: 'OOS')
        authorize @horses
    end
  
    def admins
        @horses = Horse.where.not(herd: 'OOS')
        @oos = Horse.where(herd: 'OOS')
        authorize @horses
    end

    # GET /horses/1 or /horses/1.json
    def show
    end

    # GET /horses/new
    def new
        @horse = Horse.new
        authorize @horse
    end

    # GET /horses/1/edit
    def edit
    end

    # POST /horses or /horses.json
    def create
        @horse = Horse.new(horse_params)
        authorize @horse
        respond_to do |format|
        if @horse.save
            flash[:success] = "#{@horse.name} was successfully created."
            format.html { redirect_to(helpers.horses_get_user_path(@user)) }
            format.json { render(:show, status: :created, location: @horse) }
        else
            format.html { render(:new, status: :unprocessable_entity) }
            format.json { render(json: @horse.errors, status: :unprocessable_entity) }
        end
        end
    end

    # PATCH/PUT /horses/1 or /horses/1.json
    def update
        authorize @horse
        respond_to do |format|
        if @horse.update(horse_params)
            flash[:success] = "#{@horse.name} was successfully updated."
            format.html { redirect_to(helpers.horses_get_user_path(@user)) }
            format.json { render(:show, status: :ok, location: @horse) }
        else
            format.html { render(:edit, status: :unprocessable_entity) }
            format.json { render(json: @horse.errors, status: :unprocessable_entity) }
        end
        end
    end

    def delete
        @horse = Horse.find(params[:id])
        authorize @horse
    end 
    # DELETE /horses/1 or /horses/1.json
    def destroy
        authorize @horse
        @horse.destroy

        respond_to do |format|
        format.html { redirect_to(helpers.horses_get_user_path(@user), alert: "#{@horse.name} was successfully deleted.") }
        format.json { head(:no_content) }
        end
    end

    private
        # Use callbacks to share common setup or constraints between actions.
        def set_horse
        @horse = Horse.find(params[:id])
        end

        # Only allow a list of trusted parameters through.
        def horse_params
        params.require(:horse).permit(
            :name, 
            :brand,
            :herd,
            :difficulty,
            :condition)
        end
    end
