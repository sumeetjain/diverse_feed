# == Schema Information
#
# Table name: reports
#
#  id                      :integer          not null, primary key
#  subject                 :string
#  friends_count           :integer
#  friends_in_report_count :integer
#  demographics            :text
#  user_id                 :integer
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  twitter_id              :integer
#  profile_photo           :text
#

require 'rails_helper'

RSpec.describe Report, type: :model do
  context 'with data for four users' do
    before :example do
      user1 = User.create(twitter_id: 1)
      user1.demographics.create([
        {key: 1, value: "White"},
        {key: 2, value: 20000}
      ])

      user2 = User.create(twitter_id: 2)
      user2.demographics.create([
        {key: 1, value: "White"},
        {key: 2, value: 45000}
      ])

      user3 = User.create(twitter_id: 3)
      user3.demographics.create([
        {key: 1, value: "Black"},
        {key: 2, value: 60000}
      ])

      user4 = User.create(twitter_id: 4)
      user4.demographics.create([
        {key: 1, value: "Indian"},
        {key: 2, value: 65000}
      ])

      @report = Report.new(subject: "hul", twitter_client: FakeTwitter.new)
      @report.save

      @report2 = Report.new(subject: "sumeetjain", twitter_client: FakeTwitter.new, updated_at: Time.now - 24.hours)
      @report2.save
    end

    describe '#create' do
      it "sets friends_count" do
        expect(@report.friends_count).to eq(5)
      end

      it "sets friends_in_report_count" do
        expect(@report.friends_in_report_count).to eq(4)
      end

      it "sets demographics, race" do
        expect(@report.demographics[:race]).to include({
          "White"  => 50.0,
          "Black"  => 25.0,
          "Indian" => 25.0
        })
      end

      it "sets demographics, income" do
        expect(@report.demographics[:income]).to include({
          20000 => 25.0,
          45000 => 25.0,
          60000 => 25.0,
          65000 => 25.0
        })
      end
		end

		describe '.recent_report' do
			it "returns a recent report when there is one" do
				expect(Report.recent_report("hul")).to eq(@report)
			end

			it "returns nil if there's no recent report" do
				expect(Report.recent_report("sumeetjain")).to be_nil
			end
		end
	end

  describe '.random' do
    it "gets a random report" do
      # Setup
      Report.destroy_all

      Report.create(subject: "A", twitter_client: FakeTwitter.new)
      Report.create(subject: "B", twitter_client: FakeTwitter.new)
      Report.create(subject: "C", twitter_client: FakeTwitter.new)

      # Stub the actual randomizer with a hard-coded value, so I can predict
      # the result of Report.random.
      expect(Report).to receive(:random_offset) { 1 }

      # Exercise/Verify
      expect(Report.random.subject).to eq("B")
    end
  end
end
