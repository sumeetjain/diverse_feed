class ReportsController < ApplicationController
  def show
    report = Report.find(params[:id])
    @report = ReportPresenter.new(report)
  end

  def new
    if current_user
      @report = current_user.reports.build
    else
      session[:return_to] = new_report_url
      redirect_to "/login"
    end
  end

  def create
    if (@report = Report.recent_report(report_params[:subject]))
      redirect_to @report, notice: "Report loaded!"
    else
      @report = current_user.reports.build(report_params)
      if @report.save
        redirect_to @report, notice: "Report generated!"
      else
        flash.now[:alert] = "There was a problem."
        render :new
      end
    end
  end

  private

  def report_params
    params.require(:report).permit(:subject)
  end
end
