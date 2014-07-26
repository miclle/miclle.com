class AddUuidToUsers < ActiveRecord::Migration
  def change
    add_column  :users, :uuid, :string, :limit => 32
    add_index   :users, :uuid, :unique => true

    User.all.map{ |u| u.uuid = SecureRandom.uuid.gsub("-",""); u.save }
  end
end
