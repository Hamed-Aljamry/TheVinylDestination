require 'rspotify'

class VinylsController < ApplicationController
  def index
    @vinyls = Vinyl.all
    @vinyl = Vinyl.new

    if params[:query].present?
      @vinyls = @vinyls.where("name ILIKE ? OR artist ILIKE ?", "%#{params[:query]}%", "%#{params[:query]}%")
    else
      @vinyls = Vinyl.all
    end

    if turbo_frame_request?
      render partial: "vinyls", locals: { vinyls: @vinyls }
    else
      render :index
    end
  end

  def search_songs
    @query = params[:query]
    @tracks = RSpotify::Track.search(@query)
  end

  def play_song
    @track = RSpotify::Track.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def show
    @vinyl = Vinyl.find(params[:id])
  end

  def new
    @vinyl = Vinyl.new
    @track = RSpotify::Track.new
  end

  def create
    @vinyl = Vinyl.new(vinyl_params)
    @vinyl.user = current_user

    if @vinyl.save
      redirect_to @vinyl, notice: 'Vinyl was successfully created.'
    else
      render :new
    end
  end

  def destroy
    @vinyl = Vinyl.find(params[:id])
    @vinyl.destroy
    # No need for app/views/restaurants/destroy.html.erb
    redirect_to vinyls_path, status: :see_other
  end

  private

  def vinyl_params
    params.require(:vinyl).permit(:name, :description, :photo, :genre, :artist, :price, :track_id, :user_id, :released_at)
  end
end
