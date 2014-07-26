class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.integer :user_id
      t.string  :name
      t.text    :description
      t.integer :photo_count
      t.string  :privacy

      t.timestamps
    end
    add_index :albums, :user_id
    add_index :albums, :name
    add_index :albums, :privacy
  end
end
