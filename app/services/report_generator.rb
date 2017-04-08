class ReportGenerator
  def self.run(user_ids)
    raise TwitterService::Error::InsufficientData if user_ids.length <= 2

    demographics  = DemographicCollector.new(user_ids)
    frequency_map = DemographicMapper.new(demographics.info)

    frequency_map.to_hash
  end


end
