class HorsesController < ApplicationController
    before_action :set_horse, only: %i[ show edit update destroy ]

    # GET /horses or /horses.json
    def index
        @horses = Horse.all
    end

    def cadets
    end
  
    def staffs
        @horses = Horse.all
        authorize @horses
    end
  
    def admins
        @horses = Horse.all
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
            format.html { redirect_to(admins_horses_path, notice: "#{@horse.name} was successfully created.") }
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
            format.html { redirect_to(admins_horses_path, notice: "#{@horse.name} was successfully updated.") }
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
        @horse.destroy

        respond_to do |format|
        format.html { redirect_to(admins_horses_path, notice: "#{@horse.name} was successfully destroyed.") }
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