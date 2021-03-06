# == Schema Information
#
# Table name: users
#
#  created_at     :datetime         not null
#  id             :integer          not null, primary key
#  twitter_id     :string
#  twitter_key    :text
#  twitter_secret :text
#  updated_at     :datetime         not null
#

require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#find_or_create_from_twitter' do
    it "finds an existing user" do
      User.create(twitter_id: "abc")

      auth_hash = {
        uid: "abc"
      }

      user = User.find_or_create_from_twitter(auth_hash)

      expect(user).to_not be_nil
    end

    it "creates user that doesn't exist yet" do
      User.delete_all

      auth_hash = {
        uid: "abc",
        credentials: {
          token: "foo",
          secret: "bar"
        }
      }

      user = User.find_or_create_from_twitter(auth_hash)

      expect(user).to_not be_nil
    end
  end

  describe '#income' do
    it "returns a Demographic for a brand new user" do
      user = User.new

      expect(user.income).to be_a(Demographic)
    end

    it "returns income for a user who already saved their income" do
      user = User.new
      income = Demographic.new(key: :income, value: "50000")
      user.income = income

      expect(user.income.value).to eq("50000")
    end
  end
end
