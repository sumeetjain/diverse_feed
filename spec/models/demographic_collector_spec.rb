require "rails_helper"

RSpec.describe DemographicCollector, type: :model do
  describe '#data' do
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

      user_ids = [user1, user2, user3, user4].map { |u| u.id }
      
      collector = DemographicCollector.new(user_ids)

      friends_data = {
        "race"   => ["White", "White", "Black", "Indian"],
        "income" => [20000, 45000, 60000, 65000]
      }

      expect(collector.info).to include(friends_data)
    end

    it "gets data for users with multiple races" do
      user1 = User.create
      user1.demographics.create([
        {key: 1, value: "White"},
        {key: 1, value: "Black"},
        {key: 1, value: "Indian"},
        {key: 2, value: 20000}
      ])

      user2 = User.create
      user2.demographics.create([
        {key: 1, value: "White"},
        {key: 1, value: "Mexican"},
        {key: 2, value: 45000}
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
        {key: 2, value: 65000}
      ])

      user_ids = [user1, user2, user3, user4].map { |u| u.id }
      
      collector = DemographicCollector.new(user_ids)

      friends_data = {
        "race"   => ["White", "Black", "Indian", "White", "Mexican", "Black", "Indian", "Indian", "Mexican", "Chinese", "Latino"],
        "income" => [20000, 45000, 60000, 65000]
      }

      expect(collector.info).to include(friends_data)
    end

    it "gets data for users missing some keys" do
      user1 = User.create
      user1.demographics.create([
        {key: 1, value: "White"},
        {key: 1, value: "Black"},
        {key: 1, value: "Indian"}
      ])

      user2 = User.create
      user2.demographics.create([
        {key: 2, value: 45000}
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
        {key: 2, value: 65000}
      ])

      user_ids = [user1, user2, user3, user4].map { |u| u.id }
      
      collector = DemographicCollector.new(user_ids)

      friends_data = {
        "race"   => ["White", "Black", "Indian", "Black", "Indian", "Indian", "Mexican", "Chinese", "Latino"],
        "income" => [45000, 60000, 65000]
      }

      expect(collector.info).to include(friends_data)
    end
  end
end