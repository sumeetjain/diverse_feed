class User < ActiveRecord::Base
  def self.find_or_create_from_twitter(auth_hash)
    find_by_twitter_id(auth_hash[:uid]) || create_from_twitter(auth_hash)
  end

  private

  def self.create_from_twitter(auth_hash)
    user = self.new(
      twitter_id: auth_hash[:uid],
      twitter_key: auth_hash[:credentials][:token],
      twitter_secret: auth_hash[:credentials][:secret]
    )
    user.save
  end
end
