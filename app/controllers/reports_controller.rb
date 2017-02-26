class ReportsController < ApplicationController
  def show
    @report = Report.find(params[:id])
  end

  def new
    @report = current_user.reports.build
  end

  def create
    @report = current_user.reports.build(report_params)

    if @report.save
      redirect_to @report, notice: "Report generated!"
    else
      flash.now[:alert] = "There was a problem."
      render :new
    end
  end

  private

  def report_params
    params.require(:report).permit(:subject)
  end
end
