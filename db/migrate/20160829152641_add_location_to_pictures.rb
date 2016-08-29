class AddLocationToPictures < ActiveRecord::Migration[5.0]
  def change
    add_column :pictures, :location, :text
  end
end
