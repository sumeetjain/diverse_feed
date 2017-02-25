require 'rails_helper'

RSpec.describe TwitterService, type: :service do
  describe '#subject_friend_ids' do
    it "gets the IDs of the accounts that someone follows" do
      asker = double(:asker, twitter_key: "key", twitter_secret: "secret")

      twitter = TwitterService.new(asker: asker, client: FakeTwitter.new)

      expect(twitter.subject_friend_ids("hul")).to include(1)
    end
  end
end
