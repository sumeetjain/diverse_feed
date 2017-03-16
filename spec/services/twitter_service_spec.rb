require 'rails_helper'

RSpec.describe TwitterService, type: :service do
  describe '#subject_friend_ids' do
    it "gets the IDs of the accounts that someone follows" do
      asker = double(:asker, twitter_key: "key", twitter_secret: "secret")

      twitter = TwitterService.new(asker: asker, client: FakeTwitter.new)

      expect(twitter.subject_friend_ids("hul")).to include(1)
    end
  end

  describe '#user_id' do
    it "gets an account's Twitter ID" do
      asker = double(:asker, twitter_key: "key", twitter_secret: "secret")

      twitter = TwitterService.new(asker: asker, client: FakeTwitter.new)

      expect(twitter.user_id("hul")).to eq(10)
    end
  end

  describe '#friends_count' do
    it "counts how many friends someone has" do
      asker = double(:asker, twitter_key: ENV["ACCESS_TOKEN"], twitter_secret: ENV["ACCESS_SECRET"])

      twitter = TwitterService.new(asker: asker, client: FakeTwitter.new)

      expect(twitter.friends_count("hul")).to eq(5)
    end
  end

  describe '#avatar' do
    it "gets the URL of a given user's avatar photo" do
      asker = double(:asker, twitter_key: ENV["ACCESS_TOKEN"], twitter_secret: ENV["ACCESS_SECRET"])

      twitter = TwitterService.new(asker: asker, client: FakeTwitter.new)

      expect(twitter.avatar("hul")).to eq("http://twitter.com/example.jpg")
    end
  end
end
