class ChangeColumnName < ActiveRecord::Migration[7.0]
  def change
    rename_column :vinyls, :image, :photo
  end
end
