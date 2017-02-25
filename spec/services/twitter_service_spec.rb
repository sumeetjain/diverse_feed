require 'rails_helper'

RSpec.describe TwitterService, type: :service do
  describe '#subject_friend_ids' do
    it "gets the IDs of the accounts that someone follows" do
      asker = double
      allow(asker).to receive(:twitter_key)
      allow(asker).to receive(:twitter_secret)

      service = TwitterService.new(asker: asker, client: FakeTwitter.new)

      expect(service.subject_friend_ids("hul")).to include(1)
    end
  end
end
