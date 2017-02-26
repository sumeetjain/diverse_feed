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
#

require 'rails_helper'

RSpec.describe Report, type: :model do
  describe '#generate' do
    before :example do
      @report = Report.new(subject: "hul", twitter_service: FakeTwitter.new)
      @report.generate
    end

    it "sets twitter_id" do
      expect(@report.twitter_id).to eq(1)
    end

    it "sets friends_count" do
      expect(@report.friends_count).to eq(5)
    end

    it "sets friends_in_report_count" do
      expect(@report.friends_count).to eq(4)
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

  pending "cannot be generated if report subject follows fewer than 50 accounts total"
  pending "cannot be generated if report subject follows fewer than 10 accounts whose data is in our system"

  pending "has a count of how many accounts comprise report data"
end
