class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.string :entity_type
      t.integer :entity_id
      t.text :content
      t.timestamp :deleted_at
      t.text :reason

      t.timestamps
    end
    add_index :comments, :user_id
    add_index :comments, :entity_type
    add_index :comments, :entity_id
  end
end
