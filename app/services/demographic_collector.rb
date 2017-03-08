# DemographicCollector gets organized demographic data for a given set of User
# IDs. This organized data is meant to be passed into DemographicMapper, which
# should create a frequency map for graphing purposes.

class DemographicCollector
  attr_reader :ids, :info

  # Running list of demographic categories.
  KEYS = [
    "race",
    "income",
    "sexual_orientation",
    "religion",
  ]

  def initialize(ids)
    @ids = ids
    build_info_hash
  end

  private

  # Add each database result row's values into the @info Hash.
  def collect_demographics
    result.each do |row|
      add_to_info(row, "race")   { |v| v }
      add_to_info(row, "income") { |v| v.to_i }
      add_to_info(row, "sexual_orientation")   { |v| v }
      add_to_info(row, "religion")   { |v| v }
    end
  end

  # If there is a value in a row, add it to the @info Hash.
  # 
  # row - Hash containing a row from the database
  # key - Demographic category String (e.g. 'race')
  # &block - Block to run on the value, to allow for capitalization/formatting
  def add_to_info(row, key, &block)
    if row[key]
      @info[key] << yield(row[key])
    end
  end

  # Returns SQL String for fetching demographic data.
  def sql
    "SELECT * FROM crosstab('SELECT id, key, value FROM demographics 
      WHERE user_id IN (#{ids.join(",")}) ORDER BY 1', 
      $$VALUES (1), (2)$$) 
      AS (id int, 
      race varchar, income varchar);"
  end

  # Returns results from SQL execution as Array of Hashes.
  def result
    ActiveRecord::Base.connection.select_all(sql).entries
  end

  # Initializes @info Hash with empty Arrays for `add_to_info` to populate.
  def build_info_hash
    @info = Hash.new
    KEYS.each { |k| @info[k] = Array.new }
    
    collect_demographics
  end

end