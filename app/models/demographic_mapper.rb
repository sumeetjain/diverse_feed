class DemographicMapper
  attr_reader :friends_info

  def initialize(friends_info)
    @friends_info = friends_info
  end

  def race
    @race ||= map_race
  end

  private

  def map_race
    @race = Hash.new(0)

    @friends_info.each do |user_id, values|
      values.each { |value| @race[value] += share_amount }
    end

    @race
  end

  def share_amount
    @share_amount ||= (100.0 / @friends_info.length)
  end
end