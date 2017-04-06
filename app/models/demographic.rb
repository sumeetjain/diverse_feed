# == Schema Information
#
# Table name: demographics
#
#  created_at :datetime         not null
#  id         :integer          not null, primary key
#  key        :integer
#  updated_at :datetime         not null
#  user_id    :integer
#  value      :string
#
# Indexes
#
#  index_demographics_on_key      (key)
#  index_demographics_on_user_id  (user_id)
#  index_demographics_on_value    (value)
#
# Foreign Keys
#
#  fk_rails_dd13be0cc8  (user_id => users.id)
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
end
