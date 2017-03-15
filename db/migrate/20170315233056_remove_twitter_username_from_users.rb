class RemoveTwitterUsernameFromUsers < ActiveRecord::Migration
  def change
    remove_index :users, :twitter_username
    remove_column :users, :twitter_username, :string
  end
end
