class AddImageFileToItems < ActiveRecord::Migration
  def change
    add_column :items, :image_file, :string
  end
end
