class UsernameCleaner
  def self.username(dirty_username)
    dirty_username.gsub("@", "").gsub(/https?:\/\/.*\//, "")
  end
end
