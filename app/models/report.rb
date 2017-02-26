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
  attr_writer :twitter_client

  belongs_to :asker, class_name: "User", foreign_key: "user_id"

  serialize :demographics, Hash

  def generate
    self.twitter_id    = twitter_service.user_id(subject)
    self.friends_count = twitter_service.friends_count(subject)
  end

  private

  def twitter_service
    @twitter_service ||= TwitterService.new(asker: asker, client: @twitter_client)
  end
end
