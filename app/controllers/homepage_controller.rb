class HomepageController < ApplicationController
  def show
    @report = ReportPresenter.new(Report.random, view_context)
  end
end
