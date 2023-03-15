class AddMusicUrlToVinyls < ActiveRecord::Migration[7.0]
  def change
    add_column :vinyls, :music_url, :string
  end
end
