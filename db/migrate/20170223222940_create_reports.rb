class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.string :subject
      t.integer :friends_count
      t.integer :friends_in_report_count
      t.text :demographics
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :reports, :subject
  end
end
