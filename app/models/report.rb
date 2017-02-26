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

  before_create :generate_report_details

  private

  attr_reader :friend_twitter_ids, :friend_user_ids

  # Initializes TwitterService.
  def twitter_service
    @twitter_service ||= TwitterService.new(asker: asker, client: @twitter_client)
  end

  # Returns Integer of subject's Twitter ID.
  def twitter_id
    @twitter_id ||= twitter_service.user_id(subject)
  end

  # Returns Array of subject's friends' Twitter IDs.
  def friend_twitter_ids
    @friend_twitter_ids ||= twitter_service.subject_friend_ids(subject)
  end

  # Returns Array of subject's friends' local IDs.
  def friend_user_ids
    @friend_user_ids ||= User.select(:id)
      .where(twitter_id: friend_twitter_ids)
      .pluck(:id)
  end

  # Sets report details.
  def generate_report_details
    self.friends_count           = twitter_service.friends_count(subject)
    self.friends_in_report_count = friend_user_ids.length

    demographics                 = DemographicCollector.new(friend_user_ids)
    frequency_map                = DemographicMapper.new(demographics.info)
    self.demographics            = frequency_map.to_hash
  end
end
