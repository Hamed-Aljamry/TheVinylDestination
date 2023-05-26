class AddSongNameToVinyls < ActiveRecord::Migration[7.0]
  def change
    add_column :vinyls, :song_name, :string
  end
end
