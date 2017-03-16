# == Schema Information
#
# Table name: users
#
#  id             :integer          not null, primary key
#  twitter_id     :string
#  twitter_key    :text
#  twitter_secret :text
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

# To submit their own demographic information, a person must be a User. That
# means they have authenticated with Twitter, and we have captured their ID,
# access token, and access secret. There is no other personally identifying
# information about people in our system (e.g. SSN, name, email, etc).

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

  # Initialize a User from the OAuth flow.
  #
  # auth_hash - Hash containing the Twitter OAuth response.
  #
  # Returns a User.
  def self.find_or_create_from_twitter(auth_hash)
    find_by_twitter_id(auth_hash[:uid]) || create_from_twitter(auth_hash)
  end

  # Every user should have an income as defined by the `has_one :income`
  # association, or if not they should have an unsaved Demographic object
  # that is ready to be given a value for income.
  def income
    super || build_income
  end

  # Seed year of birth, if needed.
  def year_of_birth
    super || build_year_of_birth
  end

  private

  # Create a new user from Twitter's OAuth flow.
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
