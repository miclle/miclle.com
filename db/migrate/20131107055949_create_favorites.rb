class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.references  :user, index: true
      t.string      :favoriteable_type
      t.integer     :favoriteable_id

      t.timestamps
    end

    add_index :favorites, :favoriteable_type
    add_index :favorites, :favoriteable_id
  end
end
