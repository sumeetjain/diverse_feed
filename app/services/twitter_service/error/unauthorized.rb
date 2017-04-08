class TwitterService::Error::Unauthorized < StandardError
  MESSAGE = "Attempt to access private Twitter account's friends failed."

  def initialize(msg: MESSAGE)
    super(msg)
  end
end
