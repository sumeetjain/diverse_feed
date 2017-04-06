# == Schema Information
#
# Table name: users
#
#  created_at     :datetime         not null
#  id             :integer          not null, primary key
#  twitter_id     :string
#  twitter_key    :text
#  twitter_secret :text
#  updated_at     :datetime         not null
#

class User < ActiveRecord::Base
  has_many :reports
  has_many :demographics

  has_one :income, -> { where("key = ?",
    Demographic.keys[:income]) }, class_name: "Demographic"
  has_one :year_of_birth, -> { where("key = ?",
    Demographic.keys[:year_of_birth]) }, class_name: "Demographic"

  has_many :races, -> { where("key = ?",
    Demographic.keys[:race]) }, class_name: "Demographic"
  has_many :genders, -> { where("key = ?",
    Demographic.keys[:gender]) }, class_name: "Demographic"
  has_many :ethnicities, -> { where("key = ?",
    Demographic.keys[:ethnicity]) }, class_name: "Demographic"
  has_many :sexual_orientations, -> { where("key = ?",
    Demographic.keys[:sexual_orientation]) }, class_name: "Demographic"
  has_many :religions, -> { where("key = ?",
    Demographic.keys[:religion]) }, class_name: "Demographic"

  accepts_nested_attributes_for :income, allow_destroy: true
  accepts_nested_attributes_for :year_of_birth, allow_destroy: true

  accepts_nested_attributes_for :sexual_orientations, allow_destroy: true,
    reject_if: proc { |attrs| attrs['value'].blank? }
  accepts_nested_attributes_for :religions, allow_destroy: true,
    reject_if: proc { |attrs| attrs['value'].blank? }
  accepts_nested_attributes_for :races, allow_destroy: true,
    reject_if: proc { |attrs| attrs['value'].blank? }
  accepts_nested_attributes_for :genders, allow_destroy: true,
    reject_if: proc { |attrs| attrs['value'].blank? }
  accepts_nested_attributes_for :ethnicities, allow_destroy: true,
    reject_if: proc { |attrs| attrs['value'].blank? }

  # Internal: Get our users' IDs from a set of Twitter IDs.
  #
  # Returns an ActiveRecord::Relation containing the users' IDs.
  scope :convert_twitter_ids, -> (ids) { select(:id).where(twitter_id: ids).pluck(:id) }

  # Initialize a User from the OAuth flow.
  #
  # auth_hash - Hash containing the Twitter OAuth response.
  #
  # Returns User
  def self.find_or_create_from_twitter(auth_hash)
    find_by_twitter_id(auth_hash[:uid]) || create_from_twitter(auth_hash)
  end

  # Every user should have an income as defined by the `has_one :income`
  # association, or if not they should have an unsaved Demographic object
  # that is ready to be given a value for income.
  def income
    super || build_income
  end

  # Public: Seed year of birth, if needed.
  def year_of_birth
    super || build_year_of_birth
  end

  private

  # Internal: Create a new user from Twitter's OAuth flow.
  #
  # auth_hash - Hash containing the Twitter OAuth response.
  #
  # Returns a User.
  def self.create_from_twitter(auth_hash)
    user = self.new(
      twitter_id: auth_hash[:uid],
      twitter_key: auth_hash[:credentials][:token],
      twitter_secret: auth_hash[:credentials][:secret]
    )
    user.save and user
  end
end
