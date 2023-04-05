class VinylsController < ApplicationController
  def index
    @vinyls = Vinyl.all
    @vinyl = Vinyl.new

    if params[:query].present?
      @vinyls = @vinyls.where("name ILIKE ? OR artist ILIKE ?", "%#{params[:query]}%", "%#{params[:query]}%")
    end

    respond_to do |format|
      format.html
      format.js
    end
  end

  def search
    query = params[:query]
    if query.present?
      sql_query = "name @@ :query OR description @@ :query"
      @vinyls = Vinyl.where(sql_query, query: query)
    else
      @vinyls = Vinyl.all
    end
    render partial: "card", locals: { vinyls: @vinyls }
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
    params.require(:vinyl).permit(:name, :description, :photo, :genre, :artist, :price)
  end
end
