class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.integer :user_id
      t.integer :invitee
      t.string  :code
      t.boolean :available
      t.text    :description

      t.timestamps
    end
    add_index :invitations, :user_id
    add_index :invitations, :invitee
    add_index :invitations, :code,      :unique => true
    add_index :invitations, :available
  end
end
