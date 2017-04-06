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

require 'rails_helper'

RSpec.describe Demographic, type: :model do
end
