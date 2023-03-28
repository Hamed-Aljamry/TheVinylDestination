class VinylsController < ApplicationController
  def index
    @vinyls = Vinyl.all
  end

  def show
    @vinyl = Vinyl.find(params[:id])
  end

  def new
    @vinyl = Vinyl.new
  end

  def create
    @vinyl = Vinyl.new(vinyl_params)
    @vinyl.user = current_user
    if @vinyl.save
      redirect_to vinyl_path(@vinyl)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def vinyl_params
    params.require(:vinyl).permit(:name, :description, :image, :genre, :artist, :price)
  end
end
