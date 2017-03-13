require "rails_helper"

RSpec.describe DemographicCollector, type: :service do
  describe '#data' do
    it "gets data for a set of users" do
      user1 = User.create
      user1.demographics.create([
        {key: 1, value: "White"},
        {key: 2, value: 20000},
        {key: 3, value: "lesbian"},
        {key: 4, value: "none"}
      ])

      user2 = User.create
      user2.demographics.create([
        {key: 1, value: "White"},
        {key: 2, value: 45000},
        {key: 3, value: "bi-sexual"},
        {key: 4, value: "Muslim"}
      ])

      user3 = User.create
      user3.demographics.create([
        {key: 1, value: "Black"},
        {key: 2, value: 60000},
        {key: 3, value: "heterosexual"},
        {key: 4, value: "Jedi"}
      ])

      user4 = User.create
      user4.demographics.create([
        {key: 1, value: "Indian"},
        {key: 2, value: 65000},
        {key: 3, value: "gay"},
        {key: 4, value: "none"}
      ])

      user_ids = [user1, user2, user3, user4].map { |u| u.id }
      
      collector = DemographicCollector.new(user_ids)

      friends_data = {
        "race"   => ["White", "White", "Black", "Indian"],
        "income" => [20000, 45000, 60000, 65000],
        "sexual_orientation" => ["lesbian", "bi-sexual", "heterosexual", "gay"],
        "religion" => ["none", "Muslim", "Jedi", "none"]
      }
      expect(collector.info).to include(friends_data)
    end

    it "gets data for users with multiple races" do
      user1 = User.create
      user1.demographics.create([
        {key: 1, value: "White"},
        {key: 1, value: "Black"},
        {key: 1, value: "Indian"},
        {key: 2, value: 20000},
        {key: 3, value: "straight"},
        {key: 4, value: "Christian"}
      ])

      user2 = User.create
      user2.demographics.create([
        {key: 1, value: "White"},
        {key: 1, value: "Mexican"},
        {key: 2, value: 45000},
        {key: 3, value: "queer"},
        {key: 4, value: "Buddhist"}
      ])

      user3 = User.create
      user3.demographics.create([
        {key: 1, value: "Black"},
        {key: 1, value: "Indian"},
        {key: 2, value: 60000},
        {key: 3, value: "heterosexual"},
        {key: 4, value: "Muslim"}
      ])

      user4 = User.create
      user4.demographics.create([
        {key: 1, value: "Indian"},
        {key: 1, value: "Mexican"},
        {key: 1, value: "Chinese"},
        {key: 1, value: "Latino"},
        {key: 2, value: 65000},
        {key: 3, value: "gay"},
        {key: 4, value: "none"}
      ])

      user_ids = [user1, user2, user3, user4].map { |u| u.id }
      
      collector = DemographicCollector.new(user_ids)

      friends_data = {
        "race"   => ["White", "Black", "Indian", "White", "Mexican", "Black", "Indian", "Indian", "Mexican", "Chinese", "Latino"],
        "income" => [20000, 45000, 60000, 65000],
        "sexual_orientation" => ["straight", "queer", "heterosexual", "gay"],
        "religion" => ["Christian", "Buddhist", "Muslim", "none"]
      }

      expect(collector.info).to include(friends_data)
    end

    it "gets data for users missing some keys" do
      user1 = User.create
      user1.demographics.create([
        {key: 1, value: "White"},
        {key: 1, value: "Black"},
        {key: 1, value: "Indian"},
        {key: 3, value: "bi-sexual"},
        {key: 4, value: "Muslim"}
      ])

      user2 = User.create
      user2.demographics.create([
        {key: 2, value: 45000},
        {key: 4, value: "none"}
      ])

      user3 = User.create
      user3.demographics.create([
        {key: 1, value: "Black"},
        {key: 1, value: "Indian"},
        {key: 2, value: 60000}
      ])

      user4 = User.create
      user4.demographics.create([
        {key: 1, value: "Indian"},
        {key: 1, value: "Mexican"},
        {key: 1, value: "Chinese"},
        {key: 1, value: "Latino"},
        {key: 2, value: 65000},
        {key: 3, value: "bi-sexual"},
      ])

      user_ids = [user1, user2, user3, user4].map { |u| u.id }
      
      collector = DemographicCollector.new(user_ids)

      friends_data = {
        "race"   => ["White", "Black", "Indian", "Black", "Indian", "Indian", "Mexican", "Chinese", "Latino"],
        "income" => [45000, 60000, 65000],
        "sexual_orientation" => ["bi-sexual", "bi-sexual"],
        "religion" => ["Muslim", "none"]
      }

      expect(collector.info).to include(friends_data)
    end
  end
end