class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :twitter_id
      t.text :twitter_key
      t.text :twitter_secret

      t.timestamps null: false
    end
  end
end
