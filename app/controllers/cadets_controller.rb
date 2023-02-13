class CadetsController < ApplicationController
  before_action :set_cadet, only: %i[ show edit update destroy ]

  # GET /cadets or /cadets.json
  def index
    @cadets = Cadet.all
  end

  # GET /cadets/1 or /cadets/1.json
  def show
  end

  # GET /cadets/new
  def new
    @cadet = Cadet.new
  end

  # GET /cadets/1/edit
  def edit
  end

  # POST /cadets or /cadets.json
  def create
    @cadet = Cadet.new(cadet_params)

    respond_to do |format|
      if @cadet.save
        format.html { redirect_to cadet_url(@cadet), notice: "Cadet was successfully created." }
        format.json { render :show, status: :created, location: @cadet }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @cadet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cadets/1 or /cadets/1.json
  def update
    respond_to do |format|
      if @cadet.update(cadet_params)
        format.html { redirect_to cadet_url(@cadet), notice: "Cadet was successfully updated." }
        format.json { render :show, status: :ok, location: @cadet }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @cadet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cadets/1 or /cadets/1.json
  def destroy
    @cadet.destroy

    respond_to do |format|
      format.html { redirect_to cadets_url, notice: "Cadet was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cadet
      @cadet = Cadet.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def cadet_params
      params.require(:cadet).permit(:first_name, :last_name, :graduation_year, :phone_number, :uin, :password)
    end
end
