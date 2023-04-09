class AddTracksToVinyls < ActiveRecord::Migration[7.0]
  def change
    add_column :vinyls, :track_id, :string
  end
end
