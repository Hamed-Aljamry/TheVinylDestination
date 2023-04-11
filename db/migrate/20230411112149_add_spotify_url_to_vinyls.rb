class AddSpotifyUrlToVinyls < ActiveRecord::Migration[7.0]
  def change
    add_column :vinyls, :spotify_url, :string
  end
end
