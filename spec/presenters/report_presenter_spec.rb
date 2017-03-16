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

  describe '#friends_in_report_percentage' do
    it "indicates how many of the subject's friends are in the report" do
      report = double
      expect(report).to receive(:friends_in_report_percentage) { 30 }

      presenter = ReportPresenter.new(report)

      expect(presenter.friends_in_report_percentage).to include("30")
    end
  end

  describe '#graphs' do
    it "indicates how many of the subject's friends are in the report" do
      report = double
      expect(report).to receive(:friends_in_report_percentage) { 30 }

      presenter = ReportPresenter.new(report)

      expect(presenter.friends_in_report_percentage).to include("30")
    end
  end
end
