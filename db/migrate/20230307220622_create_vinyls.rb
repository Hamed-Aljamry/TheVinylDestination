class CreateVinyls < ActiveRecord::Migration[7.0]
  def change
    create_table :vinyls do |t|
      t.string :name
      t.text :description
      t.float :price
      t.string :image
      t.string :artist
      t.string :genre
      t.date :released_at

      t.timestamps
    end
  end
end
