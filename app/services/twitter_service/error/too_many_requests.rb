class TwitterService::Error::TooManyRequests < StandardError
  MESSAGE = "Twitter API rate limit exceeded."

  def initialize(msg: MESSAGE)
    super(msg)
  end
end
