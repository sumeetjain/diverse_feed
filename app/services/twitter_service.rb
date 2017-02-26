# Access to Twitter must go through this service. Do not call any Twitter gem
# directly from Rails. If you want to call a Twitter gem's method, wrap that
# method's functionality here first; so you can call this service's method to
# access the API however you need.

# To use TwitterService, you must provide an 'asker', which is any object that
# contains attributes for 'twitter_key' and 'twitter_secret' (which are access
# tokens for an individual Twitter user). One place where such tokens are
# stored is in the User model, since each user who authenticates for this site
# will have gone through Twitter's OAuth process.

class TwitterService
  attr_reader :client

  def initialize(asker:nil, client: nil)
    @asker = asker
    @client = client || twitter_rest_client
  end

  # Get the IDs of the accounts that someone follows.
  # 
  # subject - String account name of who to look up.
  # 
  # Returns Array of subject's friends' Twitter IDs.
  def subject_friend_ids(subject)
    client.friend_ids(subject).attrs[:ids]
  end

  # Get an account's Twitter ID.
  # 
  # subject - String account name of who to look up.
  # 
  # Returns the ID Integer.
  def user_id(subject)
    client.user(subject).id
  end

  private

  # Twitter API Gem initialization.
  def twitter_rest_client
    Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["TWITTER_KEY"]
      config.consumer_secret     = ENV["TWITTER_SECRET"]
      config.access_token        = @asker.twitter_key
      config.access_token_secret = @asker.twitter_secret
    end
  end
end