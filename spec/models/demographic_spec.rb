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

require 'rails_helper'

RSpec.describe Demographic, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
