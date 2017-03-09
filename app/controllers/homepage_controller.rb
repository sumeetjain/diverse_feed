class HomepageController < ApplicationController
  def show
    @report = Report.random
  end
end
