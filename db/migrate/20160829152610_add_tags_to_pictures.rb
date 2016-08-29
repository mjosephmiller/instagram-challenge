class AddTagsToPictures < ActiveRecord::Migration[5.0]
  def change
    add_column :pictures, :tags, :text
  end
end
