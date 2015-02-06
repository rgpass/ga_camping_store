class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.decimal :price
      t.float :rating
      t.text :description

      t.timestamps
    end
  end
end
