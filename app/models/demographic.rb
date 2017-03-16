# == Schema Information
#
# Table name: demographics
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  key        :integer
#  value      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Demographic < ActiveRecord::Base
  belongs_to :user

  # Enums define scopes for each demographic key.
  enum key: {
    race:               1,
    income:             2,
    sexual_orientation: 3,
    religion:           4,
    ethnicity:          5,
    gender:             6,
    year_of_birth:      7
  }

  def self.labels
    keys.keys.map{ |k| k.to_sym }
  end
end
