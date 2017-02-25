require 'rails_helper'

RSpec.describe DemographicMapper, type: :model do
  describe '#race' do
    it 'maps one race per friend' do
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

    it 'maps multiple races per friend' do
      # User IDs and their corresponding race info.
      friends_info = {
        1 => ["White", "Mexican"],
        2 => ["White", "Indian", "Black", "Chinese"],
        3 => ["Black"],
        4 => ["Indian", "Mexican", "Latino"]
      }

      mapper = DemographicMapper.new(friends_info)

      expect(mapper.race).to include({
        "White"  => 20.0,
        "Mexican" => 20.0,
        "Indian" => 20.0,
        "Black"  => 20.0,
        "Chinese" => 10.0,
        "Latino" => 10.0
      })
    end
  end
end
