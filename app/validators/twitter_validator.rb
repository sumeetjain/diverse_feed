class TwitterValidator < ActiveModel::Validator
  def validate(record)
    begin
      record.generate_report_details
    rescue TwitterService::Error::InsufficientData
      record.errors.add(:base, I18n.t("twitter_errors.not_enough_friends")) and :abort
    rescue TwitterService::Error::Unauthorized
      record.errors.add(:base, I18n.t("twitter_errors.unauthorized")) and :abort
    rescue TwitterService::Error::TooManyRequests
      record.errors.add(:base, I18n.t("twitter_errors.too_many_requests")) and :abort
    end
  end
end


# validates :friends_in_report_count,
#   numericality: {
#     greater_than: 2,

#     # object = person object being validated
#     # data = { model: "Person", attribute: "Username", value: <username> }
#     message: -> (object, data) do
#       "Only #{data[:value].to_i} of the accounts this person follows have provided demographic information to us. Unfortunately, that's not enough for us to build a meaningful report. Please try again some time in the future, when hopefully more of them will have participated in this project."
#     end
#   }
