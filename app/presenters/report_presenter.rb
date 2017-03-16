class ReportPresenter
  attr_reader :report, :labels

  def initialize(report, view_context)
    @report = report
    @labels = report.labels
    @view_context = view_context
    @first_graph = true
  end

  def graphs
    @labels.map do |key, foo|
      GraphPresenter.new(key, @report.demographics[key], @view_context)
    end
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

  def first_graph?
    if @first_graph == true
      true
    else
      @first_graph = false
      false
    end
  end
end
