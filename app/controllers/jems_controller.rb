class JemsController < ApplicationController
  before_action :set_jem, only: [:show, :edit, :update, :destroy]

 # def jem_path
 # end

  # GET /jems
  # GET /jems.json
  def index
    # Sorted
    @jems = Jem.all.order(:name)
  end

  # GET /jems/aGem
  # GET /jems/aGem.json
  def show
  end

  # GET /jems/new
  def new
    @jem = Jem.new
  end

  # GET /jems/aGem/edit
  def edit
  end

  # POST /jems
  # POST /jems.json
  def create
    @jem = Jem.new(jem_params)

    respond_to do |format|
      if @jem.save
        format.html { redirect_to @jem, notice: 'Jem was successfully created.' }
        format.json { render :show, status: :created, location: @jem }
      else
        format.html { render :new }
        format.json { render json: @jem.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /jems/aGem
  # PATCH/PUT /jems/aGem.json
  def update
    respond_to do |format|
      if @jem.update(jem_params)
        format.html { redirect_to @jem, notice: 'Jem was successfully updated.' }
        format.json { render :show, status: :ok, location: @jem }
      else
        format.html { render :edit }
        format.json { render json: @jem.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jems/aGem
  # DELETE /jems/aGem.json
  def destroy
    @jem.destroy
    respond_to do |format|
      format.html { redirect_to jems_url, notice: 'Jem was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_jem
      # Change from id to name - zL
      @jem = Jem.find(params[:name])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def jem_params
      params.require(:jem).permit(:name, :seq, :comment)
    end
end
