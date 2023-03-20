class VinylsController < ApplicationController
  def index
    @vinyls = Vinyl.all
  end

  def show
    @vinyl = Vinyl.find(params[:id])
  end

  private

  def vinyl_params
    params.require(:vinyl).permit(:name, :description, :image, :genre, :artist, :price)
  end
end
