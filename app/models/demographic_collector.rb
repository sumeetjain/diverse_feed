class DemographicCollector
  def initialize(ids)
    @ids = ids
  end

  def info
    sql = "SELECT * FROM crosstab('SELECT id, key, value FROM demographics WHERE user_id IN (#{@ids.join(",")}) ORDER BY 1', $$VALUES (1), (2)$$) AS (id int, race varchar, income varchar);"
    result = ActiveRecord::Base.connection.select_all(sql).entries

    friends_data = {
      "race"   => [],
      "income" => []
    }

    result.each do |row|
      (friends_data["race"]   << row["race"]) if row["race"]
      (friends_data["income"] << row["income"].to_i) if row["income"]
    end

    friends_data
  end
end