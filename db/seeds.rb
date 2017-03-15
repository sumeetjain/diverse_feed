accts = YAML.load_file(Rails.root.join('lib', 'top_twitter_accounts.yml'))

accts.each do |twitter_username, info|
  if !info.nil?
    user = User.new(twitter_username: twitter_username)

    info["ethnicity"].each { |ethnicity| user.races.build(
      key: :race,
      value: ethnicity) }

    user.save!
    puts "Created user: #{user.inspect}"
  end
end
