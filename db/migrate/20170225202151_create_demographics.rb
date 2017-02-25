class CreateDemographics < ActiveRecord::Migration
  def change
    create_table :demographics do |t|
      t.references :user, index: true, foreign_key: true
      t.integer :key
      t.string :value

      t.timestamps null: false
    end
    add_index :demographics, :key
    add_index :demographics, :value
  end
end
