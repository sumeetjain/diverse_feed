class TwitterService::Error::InsufficientData < StandardError
  MESSAGE = "There is not enough information to process this request."

  def initialize(msg: MESSAGE)
    super(msg)
  end
end
