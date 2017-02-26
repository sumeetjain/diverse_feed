class ReportsController < ApplicationController
  def show
    @report = Report.find(:id)
  end

  def new
    @report = Report.new
  end

  def create
    @report = Report.new(params[:report])

    if @report.save
      redirect_to @report, notice: "Report generated!"
    else
      flash.now[:alert] = "There was a problem."
      render :new
    end
  end
end
