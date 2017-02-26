# This implements the API of whatever Twitter gem we're using. Essentially, any
# time you see `client.something` in TwitterService, there should be a 
# corresponding `def something...` in FakeTwitter that returns fake data in the
# expected format. This way, TwitterService can easily be tested without
# actually having to connect to Twitter.

class FakeTwitter
  def friend_ids(subject)
    attrs = {ids: [1, 2, 3, 4, 5]}
    OpenStruct.new(attrs: attrs)
  end

  def user(subject)
    OpenStruct.new(id: 10)
  end

  def friends_count(subject)
    subject_friend_ids(subject).length
  end
end