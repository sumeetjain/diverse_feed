# DemographicMapper takes in a collection of demographic info (probably from
# DemographicCollector) and builds frequency maps for each demographic
# category. These maps should be pretty easy to pass off to a graphing library
# for creating pie charts or some other visual graphic showing what percentage
# of a person's friends are of a given demographic value.

class DemographicMapper
  attr_reader :friends_info, :race, :income, :sexual_orientation, :religion

  def initialize(friends_info)
    @friends_info = friends_info
    @race = map_race
    @income = map_income
    @sexual_orientation = map_sexual_orientation
    @religion = map_religion
  end

  def to_hash
    {
      race:   map_race,
      income: map_income,
      sexual_orientation: map_sexual_orientation,
      religion: map_religion
    }
  end

  private

  # Count proportions of each particular 'race' value in friends_info.
  # 
  # Returns Hash of values and percentage of that value's makeup.
  def map_race
    @race = Hash.new(0)

    @friends_info["race"].each do |value|
      @race[value] += share_amounts["race"]
    end

    @race
  end

  # Count proportions of each particular 'income' value in friends_info.
  # 
  # Returns Hash of values and percentage of that value's makeup.
  def map_income
    @income = Hash.new(0)

    @friends_info["income"].each do |value|
      @income[value] += share_amounts["income"]
    end

    @income
  end

  # Count proportions of each particular 'sexual orientation' value in friends_info.
  #
  # Returns Hash of values and percentage of that value's makeup.
  def map_sexual_orientation
    @sexual_orientation = Hash.new(0)

    @friends_info["sexual_orientation"].each do |value|
      @sexual_orientation[value] += share_amounts["sexual_orientation"]
    end

    @sexual_orientation
  end

  # Count proportions of each particular 'religion' value in friends_info.
  #
  # Returns Hash of values and percentage of that value's makeup.
  def map_religion
    @religion = Hash.new(0)

    @friends_info["religion"].each do |value|
      @religion[value] += share_amounts["religion"]
    end

    @religion
  end

  # Returns Hash containing each key's share_amount.
  def share_amounts
    share_amounts_arr = @friends_info.map do |key, values_hash|
      [key, share_amount(key)]
    end

    @share_amounts ||= share_amounts_arr.to_h
  end

  # Proportion each demographic value adds to its key's tally.
  # 
  # key - Symbol for demographic key (e.g. `:race`)
  # 
  # Returns Float.
  def share_amount(key)
    (100.0 / @friends_info[key].length).round(2)
  end
end