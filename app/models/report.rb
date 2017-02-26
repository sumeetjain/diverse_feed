# == Schema Information
#
# Table name: reports
#
#  id                      :integer          not null, primary key
#  subject                 :string
#  friends_count           :integer
#  friends_in_report_count :integer
#  demographics            :text
#  user_id                 :integer
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  twitter_id              :integer
#

class Report < ActiveRecord::Base
  attr_writer :twitter_service

  belongs_to :asker, class_name: "User", foreign_key: "user_id"

  serialize :demographics, Hash

  # def twitter_id
  #   @twitter_id ||= 
  # end

  def generate
  end

  private

  def twitter_service
    @twitter_service ||= TwitterService.new(asker)
  end
end
