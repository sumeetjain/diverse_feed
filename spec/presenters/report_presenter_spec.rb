require "rails_helper"

RSpec.describe ReportPresenter, type: :presenter do
  describe '#subject' do
    it "returns the subject's Twitter username" do
      report = double
      expect(report).to receive(:subject) { "sumeetjain" }

      presenter = ReportPresenter.new(report)

      expect(presenter.subject).to eq("@sumeetjain")
    end
  end

  describe '#friends_count' do
    it "indicates how many friends the report subject has" do
      report = double
      expect(report).to receive(:friends_count) { 99 }

      presenter = ReportPresenter.new(report)

      expect(presenter.friends_count).to include("99")
    end
  end

  describe '#friends_in_report' do
    it "indicates how many of the subject's friends are in the report" do
      presenter = ReportPresenter.new(double)
      expect(presenter).to receive(:friends_in_report_percentage) { 30 }

      expect(presenter.friends_in_report).to include("30")
    end
  end

  describe '#profile_photo' do
    it "gets the report subject's image URL" do
      report = double(profile_photo: "http://example.com/x.jpg")
      presenter = ReportPresenter.new(report)

      expect(presenter.profile_photo).to eq("http://example.com/x.jpg")
    end

    it "returns a default image if the report subject has no avatar URL" do
      report = double(profile_photo: nil)
      presenter = ReportPresenter.new(report)

      expect(presenter.profile_photo).to_not be_nil
    end
  end
end
