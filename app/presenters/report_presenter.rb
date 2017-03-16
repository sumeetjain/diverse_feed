# Prepares information from a Report record for the view.

class ReportPresenter
  attr_reader :report

  # report - Report to present to the view.
  def initialize(report)
    @report = report
  end

  # Returns an Array of all of this report's graphs.
  def graphs
    labels.map { |key| GraphPresenter.new(key, @report.demographics[key]) }
  end

  # Returns a String of this report's subject (e.g. "@sumeetjain").
  def subject
    "@#{report.subject}"
  end

  # Returns a String containing how many accounts the subject follows.
  def friends_count
    "Follows #{report.friends_count} accounts"
  end

  # Returns a String indicating how many of the subject's friends we have
  # demographic data for.
  def friends_in_report_percentage
    "Report based upon #{report.friends_in_report_percentage}% of accounts followed"
  end

  # Returns String with the profile photo to show for this report's subject.
  def profile_photo
    @report.profile_photo || "egg.jpg"
  end

  private

  # Returns an Array containing only those demographic keys (e.g. 'race',
  # 'gender') for which there is actually information to show.
  def labels
    @report.demographics.map { |key, values| key if !values.blank? }.compact
  end
end
