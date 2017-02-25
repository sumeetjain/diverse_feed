class TwitterService
  attr_reader :client
  
  def initialize(asker)
    @client ||= Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["TWITTER_KEY"]
      config.consumer_secret     = ENV["TWITTER_SECRET"]
      config.access_token        = asker.twitter_key
      config.access_token_secret = asker.twitter_secret
    end
  end

  # Get the IDs of the accounts that someone follows.
  # 
  # subject - String account name of who to look up.
  # 
  # Returns Array of subject's friends' Twitter IDs.
  def subject_friend_ids(subject)
    client.friend_ids(subject).attrs[:ids]
  end
end