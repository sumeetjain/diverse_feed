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
  describe '.info_for' do
    it "gets demographic data for the subject's friends" do
      info = Demographic.info_for(1)

      friends_data = {
        race: {
          1 => ["White"],
          2 => ["White"],
          3 => ["Black"],
          4 => ["Indian"]
        },
        income: {
          1 => 20000,
          2 => 45000,
          3 => 60000,
          4 => 65000
        }
      }

      expect(info).to include(friends_data)
    end
  end
end
