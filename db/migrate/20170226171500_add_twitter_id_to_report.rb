class AddTwitterIdToReport < ActiveRecord::Migration
  def change
    add_column :reports, :twitter_id, :integer
    add_index :reports, :twitter_id
  end
end
