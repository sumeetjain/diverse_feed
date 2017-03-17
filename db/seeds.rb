require "csv"

asker = User.new(twitter_key: ENV["ACCESS_TOKEN"], twitter_secret: ENV["ACCESS_SECRET"])

TWITTER_SERVICE = TwitterService.new(asker: asker)

CSV.foreach(Rails.root.join('lib', 'seeds.csv'), {headers: true}) do |row|
  twitter_id = TWITTER_SERVICE.user_id(row["twitter_username"])

  if twitter_id
    user = User.new(twitter_id: twitter_id)

    user.genders.build(
      key: :gender,
      value: row["gender"]) if !row["gender"].blank?

    user.races.build(
      key: :race,
      value: row["race"]) if !row["race"].blank?

    user.build_year_of_birth(
      key: :year_of_birth,
      value: row["year_of_birth"]) if !row["year_of_birth"].blank?

    unless row["ethnicities"].blank?
      ethnicities = row["ethnicities"].split(",").map { |e| e.strip }

      ethnicities.each { |ethnicity| user.ethnicities.build(
        key: :ethnicity,
        value: ethnicity) }
    end

    user.save!
    puts "Created user: #{user.inspect} - #{user.demographics.select(:key, :value).inspect}"
  end
end
