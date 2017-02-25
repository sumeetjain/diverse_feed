# == Schema Information
#
# Table name: users
#
#  id             :integer          not null, primary key
#  twitter_id     :string
#  twitter_key    :text
#  twitter_secret :text
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#find_or_create_from_twitter' do
    it "finds an existing user" do
      User.create(twitter_id: "abc")

      auth_hash = {
        uid: "abc"
      }

      user = User.find_or_create_from_twitter(auth_hash)

      expect(user).to_not be_nil
    end

    it "creates user that doesn't exist yet" do
      User.delete_all
      
      auth_hash = {
        uid: "abc",
        credentials: {
          token: "foo",
          secret: "bar"
        }
      }

      user = User.find_or_create_from_twitter(auth_hash)

      expect(user).to_not be_nil
    end
  end
end
