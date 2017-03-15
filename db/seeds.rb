require "csv"

CSV.foreach(Rails.root.join('lib', 'seeds.csv'), {headers: true}) do |row|
  user = User.new(twitter_username: row["twitter_username"])

  user.genders.build(
    key: :gender,
    value: row["gender"]) if !row["gender"].blank?

  user.races.build(
    key: :race,
    value: row["race"]) if !row["race"].blank?

  user.build_year_of_birth(
    key: :year_of_birth,
    value: row["year_of_birth"]) if !row["year_of_birth"].blank?

  ethnicities = row["ethnicities"].split(",").map { |e| e.strip }

  ethnicities.each { |ethnicity| user.ethnicities.build(
    key: :ethnicity,
    value: ethnicity) }

  user.save!
  puts "Created user: #{user.inspect} - #{user.demographics.select(:key, :value).inspect}"
end
