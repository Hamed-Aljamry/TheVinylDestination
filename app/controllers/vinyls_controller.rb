require 'rspotify'
require 'open-uri'

class VinylsController < ApplicationController
  def index
    @vinyls = Vinyl.all
    @vinyl = Vinyl.new
    @vinyls = Vinyl.order(created_at: :desc)

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

  def show
    @vinyl = Vinyl.find(params[:id])
  end

  def new
    @vinyl = Vinyl.new
    @track = RSpotify::Track.new
  end

  def create
    @vinyl = Vinyl.new(vinyl_params)
    song_name = params[:vinyl][:song_name]
    artist = params[:vinyl][:artist]

    # Search for the song on Spotify
    results = RSpotify::Track.search("#{song_name} #{artist}")

    if results.any?
      track = results.first
      # p track
      @vinyl.user = current_user
      @vinyl.song_id = track.id
      @vinyl.spotify_url = track.external_urls['spotify']
      @vinyl.name = track.name
      @vinyl.artist = track.artists.first.name
      @vinyl.music_url = track.preview_url
      @vinyl.description = "Who cares"
      @vinyl.genre = "Whevs"
      photo = URI.open(track.album.images.first["url"])
      @vinyl.photo.attach(io: photo, filename: track.album.images.first["url"].split("/").last)
      # Set other vinyl attributes as needed

      if @vinyl.save
        # p @vinyl
        redirect_to vinyl_path(@vinyl), notice: 'Vinyl created successfully.'
      else
        # p @vinyl
        # p @vinyl.errors.messages
        render :new
      end
    else
      flash.now[:alert] = 'Song not found on Spotify.'
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
    params.require(:vinyl).permit(:name, :url, :description, :photo, :genre, :artist, :price, :track_id, :user_id, :released_at, :song_name)
  end
end
