class AddStateToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :state, :string
    add_index :photos, :state
    add_index :photos, :privacy
  end
end
