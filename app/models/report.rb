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
#  profile_photo           :text
#

class Report < ActiveRecord::Base
  attr_writer :twitter_client
  attr_accessor :fetched_friends

  belongs_to :asker, class_name: "User", foreign_key: "user_id"

  serialize :demographics, Hash

  validates :friends_in_report_count,
    numericality: {
      greater_than: 9,

      # object = person object being validated
      # data = { model: "Person", attribute: "Username", value: <username> }
      message: -> (object, data) do
        "Only #{data[:value].to_i} of the accounts this person follows have provided demographic information to us. Unfortunately, that's not enough for us to build a meaningful report. Please try again some time in the future, when hopefully more of them will have participated in this project."
      end
    },
    if: :fetched_friends

    validates :subject, presence: true

  before_validation :fetch_friends
  before_create :generate_report_details

  def subject=(input)
    @subject = input.gsub("@", "").gsub(/https?:\/\/.*\//, "")
  end

  def fetch_friends
    begin
      self.friends_count           = twitter_service.friends_count(subject)
      self.friends_in_report_count = friend_user_ids.length
      self.fetched_friends = true
    rescue Twitter::Error::TooManyRequests => error
      errors.add(:twitter, "only allows for a handful of requests per user at a time. Please try again in ~10 minutes.") and :abort
    rescue Twitter::Error::Unauthorized => error
      errors.add(:twitter, "won't allow us to view whom @#{subject} follows, so we can't run their report.") and :abort
    end
  end

  # Returns a random Report.
  def self.random
    offset(random_offset).first
  end

  # Checks to see if report has already been created within last 12 hours
  def self.recent_report(subject)
    where(subject: subject, updated_at: (Time.now - 12.hours)..Time.now).first
  end

  # Returns percentage of friends who make up this report.
  def friends_in_report_percentage
    percentage = (friends_in_report_count.to_f / friends_count.to_f).round(2)
    percentage = percentage * 100

    (percentage > 2.0) ? percentage.to_i : "< 2"
  end

  private

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
    demographics       = DemographicCollector.new(friend_user_ids)
    frequency_map      = DemographicMapper.new(demographics.info)
    self.demographics  = frequency_map.to_hash
    self.profile_photo = twitter_service.avatar(subject)
  end

  # Returns a random Integer between 1 and the number of rows in 'reports'.
  def self.random_offset
    rand(count)
  end

end
