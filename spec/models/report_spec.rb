# == Schema Information
#
# Table name: reports
#
#  created_at              :datetime         not null
#  demographics            :text
#  friends_count           :integer
#  friends_in_report_count :integer
#  id                      :integer          not null, primary key
#  profile_photo           :text
#  subject                 :string
#  twitter_id              :integer
#  updated_at              :datetime         not null
#  user_id                 :integer
#
# Indexes
#
#  index_reports_on_subject     (subject)
#  index_reports_on_twitter_id  (twitter_id)
#  index_reports_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_c7699d537d  (user_id => users.id)
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
      @report.save!

      @report2 = Report.new(subject: "sumeetjain", twitter_client: FakeTwitter.new, updated_at: Time.now - 24.hours)
      @report2.save!
    end

    describe '#create' do
      context "when subject is a private user" do
        it "sets report as invalid and populates error message" do
          report = Report.create(subject: "hul", twitter_client: FakeTwitter::Unauthorized.new)

          error_text = I18n.t("twitter_errors.unauthorized")

          expect(report.errors.messages[:base]).to include(error_text)
        end

        it "doesn't also show error re: number of friends" do
          report = Report.create(subject: "hul", twitter_client: FakeTwitter::Unauthorized.new)

          expect(report.errors.messages).to_not include(:friends_in_report_count)
        end
      end

      context "when API rate limit is exceeded" do
        it "sets report as invalid and populates error message" do
          report = Report.create(subject: "hul", twitter_client: FakeTwitter::TooManyRequests.new)

          error_text = I18n.t("twitter_errors.too_many_requests")

          expect(report.errors.messages[:base]).to include(error_text)
        end

        it "doesn't also show error re: number of friends" do
          report = Report.create(subject: "hul", twitter_client: FakeTwitter::TooManyRequests.new)

          expect(report.errors.messages).to_not include(:friends_in_report_count)
        end
      end

      context "when subject doesn't have enough friends" do
        it "adds error to report" do
          report = Report.create(subject: "hul", twitter_client: FakeTwitter::NoFriends.new)

          error_text = I18n.t("twitter_errors.not_enough_friends")

          expect(report.errors.messages[:base]).to include(error_text)
        end
      end

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

  # describe '.random' do
  #   it "gets a random report" do
  #     # Setup
  #     Report.destroy_all

  #     reportA = Report.create(subject: "hul", twitter_client: FakeTwitter.new)
  #     reportB = Report.create(subject: "hul", twitter_client: FakeTwitter.new)
  #     reportC = Report.create(subject: "hul", twitter_client: FakeTwitter.new)

  #     # Stub the actual randomizer with a hard-coded value, so I can predict
  #     # the result of Report.random.
  #     expect(Report).to receive(:random_offset) { 1 }

  #     # Exercise/Verify
  #     expect(Report.random).to eq(reportB)
  #   end
  # end
end
