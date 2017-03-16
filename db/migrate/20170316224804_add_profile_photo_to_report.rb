class AddProfilePhotoToReport < ActiveRecord::Migration
  def change
    add_column :reports, :profile_photo, :text
  end
end
