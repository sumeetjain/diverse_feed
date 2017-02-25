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
