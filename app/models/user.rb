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

# To submit their own demographic information, a person must be a User. That
# means they have authenticated with Twitter, and we have captured their ID,
# access token, and access secret. There is no other personally identifying
# information about people in our system (e.g. SSN, name, email, etc).

class User < ActiveRecord::Base
  has_many :reports
  has_many :demographics

  # Initialize a User from the OAuth flow.
  # 
  # auth_hash - Hash containing the Twitter OAuth response.
  # 
  # Returns a User.
  def self.find_or_create_from_twitter(auth_hash)
    find_by_twitter_id(auth_hash[:uid]) || create_from_twitter(auth_hash)
  end

  private

  # Create a new user from Twitter's OAuth flow.
  # 
  # auth_hash - Hash containing the Twitter OAuth response.
  # 
  # Returns a User.
  def self.create_from_twitter(auth_hash)
    user = self.new(
      twitter_id: auth_hash[:uid],
      twitter_key: auth_hash[:credentials][:token],
      twitter_secret: auth_hash[:credentials][:secret]
    )
    user.save and user
  end
end
