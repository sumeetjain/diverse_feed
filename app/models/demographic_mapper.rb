class DemographicMapper
  attr_reader :friends_info, :race

  def initialize(friends_info)
    @friends_info = friends_info
    @race = map_race
  end

  private

  # Count proportions of each particular 'race' value in @friends_info.
  # 
  # Returns Hash of values and percentage of that value's makeup.
  def map_race
    @race = Hash.new(0)

    @friends_info[:race].each do |user_id, values|
      values.each { |value| @race[value] += share_amount(:race) }
    end

    @race
  end

  # Returns Float proportion each demographic value adds to the tally.
  def share_amount(key)
    @share_amount ||= (100.0 / @friends_info[key].values.flatten.length)
  end
end