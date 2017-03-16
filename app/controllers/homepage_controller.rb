class HomepageController < ApplicationController
  def show
    @report = ReportPresenter.new(Report.random)
  end
end
