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

    # if params[:query].present?
    #   @vinyls = @vinyls.where("name ILIKE ? OR artist ILIKE ?", "%#{params[:query]}%", "%#{params[:query]}%")
    # end

    # respond_to do |format|
    #   format.html
    #   format.js
    # end
  end

  def get_music_url
    vinyl = Vinyl.find(params[:id])
    RSpotify.authenticate('51302eaf378e4018a925c35e23ec25b5', '54705cde78e347739ed9df87ef37011d')
    track = RSpotify::Track.search("#{vinyl.name} #{vinyl.artist}").first
    vinyl.music_url = track.preview_url
    vinyl.save
    render json: { music_url: vinyl.music_url }
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
    # track_id = params[:vinyl][:track_id]
    # @vinyl.track_url = "https://open.spotify.com/embed/track/#{track_id}"
    if @vinyl.save
      redirect_to vinyls_path
    else
      render :new, status: :unprocessable_entity
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
    params.require(:vinyl).permit(:name, :description, :photo, :genre, :artist, :price, :track_id)
  end
end
