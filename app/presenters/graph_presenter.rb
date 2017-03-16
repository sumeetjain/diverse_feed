# Prepares information from demographic data for the view. Specifically, the
# demographic data is for one person's proportions of one demographic category.
#
# For example, a single GraphPresenter object might prepare the information for
# the 'gender' breakdown of the accounts @sumeetjain follows.

class GraphPresenter
  attr_reader :id, :index

  # id               - Demographic key Symbol, e.g. `:race`.
  # demographic_data - Hash with keys representing possible demographic labels
  #                    (like "Asian", "White", and "Middle Eastern") and values
  #                    for each label's proportion.
  def initialize(id, demographic_data)
    @id = id.to_s
    @demographic_data = demographic_data
  end

  # Returns the demographic labels formatted as a JSON String.
  def labels
    @demographic_data.keys.to_json
  end

  # Returns the labels' proportions formatted as a JSON String.
  def values
    @demographic_data.values.to_json
  end

  # Returns the demographic key in title case.
  def label
    id.titleize
  end
end
