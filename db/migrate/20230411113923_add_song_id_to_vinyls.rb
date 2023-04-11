class AddSongIdToVinyls < ActiveRecord::Migration[7.0]
  def change
    add_column :vinyls, :song_id, :string
    add_index :vinyls, :song_id
  end
end
