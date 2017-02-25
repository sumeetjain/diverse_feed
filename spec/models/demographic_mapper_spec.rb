require 'rails_helper'

RSpec.describe DemographicMapper, type: :model do
  context 'for User #1' do
    it 'has race breakdown' do
      # User IDs and their corresponding race info.
      friends_info = {
        1 => ["White"],
        2 => ["White"],
        3 => ["Black"],
        4 => ["Indian"]
      }

      mapper = DemographicMapper.new(friends_info)

      expect(mapper.race).to include({
        "White"  => 50.0,
        "Black"  => 25.0,
        "Indian" => 25.0
      })
    end
  end
end
