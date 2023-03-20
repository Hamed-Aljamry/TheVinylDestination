class VinylsController < ApplicationController
  def index
    @vinyls = Vinyl.all
  end

  private

  def vinyl_params
    params.require(:vinyl).permit(:name, :description, :image, :genre, :artist, :price)
  end
end
