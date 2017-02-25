class DemographicMapper
  attr_reader :friends_info, :race, :income

  def initialize(friends_info)
    @friends_info = friends_info
    @race = map_race
    @income = map_income
  end

  private

  # Count proportions of each particular 'race' value in friends_info.
  # 
  # Returns Hash of values and percentage of that value's makeup.
  def map_race
    @race = Hash.new(0)

    @friends_info[:race].each do |user_id, values|
      values.each { |value| @race[value] += share_amount(:race) }
    end

    @race
  end

  # Count proportions of each particular 'income' value in friends_info.
  # 
  # Returns Hash of values and percentage of that value's makeup.
  def map_income
    @income = Hash.new(0)
    
    @friends_info[:income].each do |user_id, value|
      @income[value] += share_amount(:income)
    end

    @income
  end

  # Returns Float proportion each demographic value adds to the tally.
  def share_amount(key)
    @share_amount ||= (100.0 / total_values(@friends_info[key]))
  end

  # Counts how many values there are for a given part of friends_info.
  # 
  # data - Hash containing a subset of friends_info (e.g. 'race')
  # 
  # Returns Integer.
  def total_values(data)
    data.values.flatten.length
  end
end