class DemographicCollector
  def initialize(ids)
    @ids = ids
  end

  def info
    sql = "SELECT * FROM crosstab('SELECT id, key, value FROM demographics WHERE user_id IN (#{@ids.join(",")}) ORDER BY 1', $$VALUES (1), (2)$$) AS (id int, race varchar, income varchar);"
    info = ActiveRecord::Base.connection.select_all(sql).entries

    [{"id"=>"33", "race"=>"White", "income"=>nil},
     {"id"=>"34", "race"=>nil, "income"=>"20000"},
     {"id"=>"35", "race"=>"White", "income"=>nil},
     {"id"=>"36", "race"=>nil, "income"=>"45000"},
     {"id"=>"37", "race"=>"Black", "income"=>nil},
     {"id"=>"38", "race"=>nil, "income"=>"60000"},
     {"id"=>"39", "race"=>"Indian", "income"=>nil},
     {"id"=>"40", "race"=>nil, "income"=>"65000"}]

    friends_data = {
      "race"   => [],
      "income" => []
    }

    info.each do |row|
      (friends_data["race"]   << row["race"]) if row["race"]
      (friends_data["income"] << row["income"].to_i) if row["income"]
    end

    friends_data
  end
end