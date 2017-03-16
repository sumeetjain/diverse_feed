# Prepares information from a Report record for the view.

class ReportPresenter
  attr_reader :report

  # report - Report to present to the view.
  def initialize(report)
    @report = report
  end

  def graphs
    labels.map { |key| GraphPresenter.new(key, @report.demographics[key]) }
  end

  def subject
    "@#{report.subject}"
  end

  def friends_count
    "Follows #{report.friends_count} accounts"
  end

  def friends_in_report_percentage
    "Report based upon #{report.friends_in_report_percentage}% of accounts followed"
  end

  private

  def labels
    @report.demographics.map { |key, values| key if !values.blank? }.compact
  end
end
