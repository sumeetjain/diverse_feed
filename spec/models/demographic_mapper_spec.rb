require 'rails_helper'

RSpec.describe DemographicMapper, type: :model do
  context "for one value per key" do
    before(:example) do
      friends_info = {
        "race" => ["White", "White", "Black", "Indian"],
        "income" => [20000, 45000, 60000, 65000]
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
        20000 => 25.0,
        45000 => 25.0,
        60000 => 25.0,
        65000 => 25.0
      })
    end
  end

  context "for multiple values per key" do
    before(:example) do
      friends_info = {
        "race" => [
          "White", "Mexican", "White",
          "Indian", "Black", "Chinese",
          "Black", "Indian", "Mexican", "Latino"
        ],
        "income" => []
      }

      @mapper = DemographicMapper.new(friends_info)
    end

    it 'builds map for race' do
      expect(@mapper.race).to include({
        "White"   => 20.0,
        "Mexican" => 20.0,
        "Indian"  => 20.0,
        "Black"   => 20.0,
        "Chinese" => 10.0,
        "Latino"  => 10.0
      })
    end
  end

  context "for non-round values" do
    before(:example) do
      friends_info = {
        "race" => ["White", "Mexican", "Black", "Indian", "Mexican", "Latino"],
        "income" => [20000, 60000, 60000]
      }

      @mapper = DemographicMapper.new(friends_info)
    end

    it 'builds map for race' do
      expect(@mapper.race).to include({
        "White"   => 16.67,
        "Mexican" => 33.34,
        "Indian"  => 16.67,
        "Black"   => 16.67,
        "Latino"  => 16.67
      })
    end

    it 'builds map for income' do
      expect(@mapper.income).to include({
        20000 => 33.33,
        60000 => 66.66
      })
    end
  end
end
