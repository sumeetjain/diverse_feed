require 'rails_helper'

RSpec.describe DemographicMapper, type: :service do
  context "for one value per key" do
    before(:example) do
      friends_info = {
        "race" => ["White", "White", "Black", "Indian"],
        "income" => [20000, 45000, 60000, 65000],
        "sexual_orientation" => ["straight", "queer", "heterosexual", "gay"],
        "religion" => ["Christian", "Buddhist", "Muslim", "none"],
        "ethnicity" => ["Mexican", "Brazilian"],
        "gender" => ["man", "woman"],
        "year_of_birth" => [1990, 1985]
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

    it 'builds map for ethnicity' do
      expect(@mapper.ethnicity).to include({
        "Mexican" => 50.0,
        "Brazilian" => 50.0
       })
    end

    it 'builds map for sexual orientation' do
      expect(@mapper.sexual_orientation).to include({
        "straight" => 25.0,
        "queer" => 25.0,
        "heterosexual" => 25.0,
        "gay" => 25.0
       })
    end

    it 'builds map for religion' do
      expect(@mapper.religion).to include({
        "Christian" => 25.0,
        "Buddhist" => 25.0,
        "Muslim" => 25.0,
        "none" => 25.0
       })
    end

    it 'builds map for year of birth' do
      expect(@mapper.year_of_birth).to include({
        1985 => 50.0,
        1990 => 50.0
      })
    end

    it 'builds map for gender' do
      expect(@mapper.gender).to include({
        "man" => 50.0,
        "woman" => 50.0
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
        "income" => [],
        "sexual_orientation" => [],
        "religion" => [],
        "ethnicity" => ["Mexican", "Mexican", "Brazilian", "Chinese"],
        "gender" => ["man", "woman", "other", "man", "man", "man", "woman"],
        "year_of_birth" => [1990, 1985, 2000, 2000, 2000, 1990]
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

    it 'builds map for ethnicity' do
      expect(@mapper.ethnicity).to include({
        "Brazilian" => 25.0,
        "Mexican"   => 50.0,
        "Chinese"   => 25.0
      })
    end

    it 'builds map for gender' do
      expect(@mapper.gender).to include({
        "man"   => 57.16,
        "woman" => 28.58,
        "other" => 14.29
      })
    end
  end

  context "for non-round values" do
    before(:example) do
      friends_info = {
        "race" => ["White", "Mexican", "Black", "Indian", "Mexican", "Latino"],
        "income" => [20000, 60000, 60000],
        "sexual_orientation" => [],
        "religion" => ["none", "none", "Jedi"],
        "ethnicity" => ["Mexican", "Chinese", "Brazilian"],
        "gender" => ["man", "woman", "other"],
        "year_of_birth" => [1990, 1985, 2000]
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

    it 'builds map for year of birth' do
      expect(@mapper.year_of_birth).to include({
        1985 => 33.33,
        1990 => 33.33,
        2000 => 33.33
      })
    end

    it 'builds map for ethnicity' do
      expect(@mapper.ethnicity).to include({
        "Mexican" => 33.33,
        "Brazilian" => 33.33,
        "Chinese" => 33.33
       })
    end

    it 'builds map for income' do
      expect(@mapper.income).to include({
        20000 => 33.33,
        60000 => 66.66
      })
		end

    it 'builds map for religion' do
      expect(@mapper.religion).to include({
        "Jedi" => 33.33,
        "none" => 66.66
       })
    end

    it 'builds map for gender' do
      expect(@mapper.gender).to include({
        "man" => 33.33,
        "woman" => 33.33,
        "other" => 33.33
      })
    end
  end
end
