# This implements the API of whatever Twitter gem we're using. Essentially, any
# time you see `client.something` in TwitterService, there should be a
# corresponding `def something...` in FakeTwitter that returns fake data in the
# expected format. This way, TwitterService can easily be tested without
# actually having to connect to Twitter.

class FakeTwitter
  def friend_ids(subject)
    if subject == "private"
      raise Twitter::Error::Unauthorized
    else
      attrs = {ids: [1, 2, 3, 4, 5]}
      OpenStruct.new(attrs: attrs)
    end
  end

  def user(subject)
    OpenStruct.new({
      id: 10,
      profile_image_url_https: "http://twitter.com/example.jpg"
    })
  end

  def friends_count(subject)
    subject_friend_ids(subject).length
  end

  class NoFriends < self
    def friend_ids(subject)
      attrs = {ids: [1, 2]}
      OpenStruct.new(attrs: attrs)
    end
  end

  class TooManyRequests
    def method_missing(method, args)
      raise Twitter::Error::TooManyRequests
    end
  end

  class Unauthorized
    def method_missing(method, args)
      raise Twitter::Error::Unauthorized
    end
  end
end
