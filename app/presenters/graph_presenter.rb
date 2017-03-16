class GraphPresenter
  attr_reader :id, :index

  def initialize(id, demographic_data)
    @id = id.to_s
    @demographic_data = demographic_data
  end

  def labels
    @demographic_data.keys.to_json
  end

  def values
    @demographic_data.values.to_json
  end

  def label
    id.titleize
  end
end
