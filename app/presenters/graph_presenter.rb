class GraphPresenter
  attr_reader :id

  def initialize(id, demographic_data, view_context)
    @id = id.to_s
    @demographic_data = demographic_data
    @h = view_context
  end

  def render
    @h.render("reports/graph", graph: self)
  end

  def labels
    @h.raw @demographic_data.keys
  end

  def values
    @h.raw @demographic_data.values
  end

  def label
    id.titleize
  end
end
