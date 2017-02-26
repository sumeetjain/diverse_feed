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
#

require 'rails_helper'

RSpec.describe Report, type: :model do
  describe '.collect_demographics' do
    it "gets data for a set of users" do
      user1 = User.create
      user1.demographics.create([
        {key: 1, value: "White"},
        {key: 2, value: 20000}
      ])

      user2 = User.create
      user2.demographics.create([
        {key: 1, value: "White"},
        {key: 2, value: 45000}
      ])

      user3 = User.create
      user3.demographics.create([
        {key: 1, value: "Black"},
        {key: 2, value: 60000}
      ])

      user4 = User.create
      user4.demographics.create([
        {key: 1, value: "Indian"},
        {key: 2, value: 65000}
      ])
      
      info = Report.collect_demographics([user1, user2, user3, user4].map {|u| u.id})

      friends_data = {
        "race"   => ["White", "White", "Black", "Indian"],
        "income" => [20000, 45000, 60000, 65000]
      }

      expect(info).to include(friends_data)
    end
  end

  pending "cannot be generated if report subject follows fewer than 50 accounts total"
  pending "cannot be generated if report subject follows fewer than 10 accounts whose data is in our system"

  pending "has a count of how many accounts comprise report data"
  
  pending "has ethnicity breakdown"
  pending "has gender breakdown"
  pending "has sexual orientation breakdown"
  pending "has political orientation breakdown"
  pending "has age breakdown"
  pending "has income breakdown"
end
