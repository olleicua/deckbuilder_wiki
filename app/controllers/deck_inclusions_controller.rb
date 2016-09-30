class DeckInclusionsController < ApplicationController
  before_action :set_inclusion, only: [:update, :destroy]

  # POST /inclusions.json
  def create
    @inclusion = Inclusion.new(inclusion_params)

    if @inclusion.save
      render :show, status: :created, location: @inclusion
    else
      render json: @inclusion.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /inclusions/1.json
  def update
    if @inclusion.update(inclusion_params)
      render :show, status: :ok, location: @inclusion
    else
      render json: @inclusion.errors, status: :unprocessable_entity
    end
  end

  # DELETE /inclusions/1.json
  def destroy
    @inclusion.destroy
    head :no_content
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_inclusion
    @inclusion = DeckInclusion.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def inclusion_params
    params.require(:inclusion).permit(:deck_id, :card_id, :quantity, :sideboard)
  end
end
