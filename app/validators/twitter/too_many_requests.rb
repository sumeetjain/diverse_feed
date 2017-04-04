class TwitterValidator::TooManyRequests < ActiveModel::Validator
  def validate(record)
    begin
      self.friends_count           = twitter_service.friends_count(subject)
      self.friends_in_report_count = friend_user_ids.length
      self.fetched_friends = true
    rescue Twitter::Error::TooManyRequests => error
      errors.add(:twitter, ) and :abort
    rescue Twitter::Error::Unauthorized => error
      errors.add(:twitter, I18n.t("twitter_errors.unauthorized")) and :abort
    end


    if some_complex_logic
      record.errors.add :base, I18n.t("twitter_errors.too_many_requests")
    end
  end

  private
    def some_complex_logic
      # ...
    end
end
