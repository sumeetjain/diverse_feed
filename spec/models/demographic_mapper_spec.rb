require 'rails_helper'

RSpec.describe DemographicMapper, type: :model do
  context "for one value per key" do
    before(:example) do
      friends_info = {
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

      @mapper = DemographicMapper.new(friends_info)
    end

    it 'builds map for race' do
      expect(@mapper.race).to include({
        "White"  => 50.0,
        "Black"  => 25.0,
        "Indian" => 25.0
      })
    end

    it 'builds map for income' do
      expect(@mapper.income).to include({
        20000  => 25.0,
        45000  => 25.0,
        60000 => 25.0,
        65000 => 25.0
      })
    end
  end

  context "for multiple values per key" do
    before(:example) do
      friends_info = {
        race: {
          1 => ["White", "Mexican"],
          2 => ["White", "Indian", "Black", "Chinese"],
          3 => ["Black"],
          4 => ["Indian", "Mexican", "Latino"]
        },
        income: {}
      }

      @mapper = DemographicMapper.new(friends_info)
    end

    it 'builds map for race' do
      expect(@mapper.race).to include({
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
