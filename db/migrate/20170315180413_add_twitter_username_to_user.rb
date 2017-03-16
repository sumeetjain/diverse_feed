class AddTwitterUsernameToUser < ActiveRecord::Migration
  def change
    add_column :users, :twitter_username, :string
    add_index :users, :twitter_username
  end
end
