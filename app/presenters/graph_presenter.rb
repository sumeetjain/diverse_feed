class GraphPresenter
  attr_reader :id, :index

  def initialize(id, demographic_data, view_context)
    @id = id.to_s
    @demographic_data = demographic_data
    @h = view_context
  end

  def render(index)
    @index = index
    @h.render("reports/graph", graph: self)
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
