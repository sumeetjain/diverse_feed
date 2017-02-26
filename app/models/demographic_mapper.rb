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