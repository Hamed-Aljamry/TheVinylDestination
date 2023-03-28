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
    @vinyl = Vinyl.new(params[:vinyl])
    @vinyl.save # Will raise ActiveModel::ForbiddenAttributesError
    redirect_to
  end

  private

  def vinyl_params
    params.require(:vinyl).permit(:name, :description, :image, :genre, :artist, :price)
  end
end
