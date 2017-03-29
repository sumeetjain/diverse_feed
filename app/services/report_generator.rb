class ReportGenerator
  def self.run(user_ids)
    return if user_ids.empty?

    demographics  = DemographicCollector.new(user_ids)
    frequency_map = DemographicMapper.new(demographics.info)

    frequency_map.to_hash
  end
end
