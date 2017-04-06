# == Schema Information
#
# Table name: reports
#
#  created_at              :datetime         not null
#  demographics            :text
#  friends_count           :integer
#  friends_in_report_count :integer
#  id                      :integer          not null, primary key
#  profile_photo           :text
#  subject                 :string
#  twitter_id              :integer
#  updated_at              :datetime         not null
#  user_id                 :integer
#
# Indexes
#
#  index_reports_on_subject     (subject)
#  index_reports_on_twitter_id  (twitter_id)
#  index_reports_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_c7699d537d  (user_id => users.id)
#

class Report < ActiveRecord::Base
  attr_writer :twitter_client

  belongs_to :asker, class_name: "User", foreign_key: "user_id"

  serialize :demographics, Hash

  validates :subject, presence: true
  validates_with TwitterValidator

  before_create :set_profile_photo

  # Sets report details.
  def generate_report_details
    self.demographics = ReportGenerator.run(friend_user_ids)
  end

  # Removes extraneous information from the username.
  #
  # This setter method is automatically called before this Report record is
  # saved (built-in behavior of ActiveRecord.)
  #
  # input - String of the subject's username.
  def subject=(input)
    super UsernameCleaner.username(input)
  end

  # Returns a random Report.
  def self.random
    offset(random_offset).first
  end

  # Checks to see if report has already been created within last 12 hours
  def self.recent_report(subject)
    where(subject: subject, updated_at: (Time.now - 12.hours)..Time.now).first
  end

  # Returns Integer of how many of subject's friends are included in report.
  def friends_in_report_count
    @friends_in_report_count ||= friend_user_ids.length
  end

  # Returns Integer of how many friends subject has.
  def friends_count
    @friends_count ||= twitter_service.friends_count(subject)
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
    @friend_user_ids ||= User.convert_twitter_ids(friend_twitter_ids)
  end

  def set_profile_photo
    self.profile_photo = @twitter_service.avatar(subject)
  end

  # Returns a random Integer between 1 and the number of rows in 'reports'.
  def self.random_offset
    rand(count)
  end

end
