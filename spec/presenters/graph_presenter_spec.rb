require "rails_helper"

RSpec.describe GraphPresenter, type: :presenter do
  describe '#labels' do
    it "formats labels into a JSON Array String" do
      demographic_data = double
      sample_keys = ["Asian", "White", "Middle Eastern"]
      expect(demographic_data).to receive(:keys) { sample_keys }

      presenter = GraphPresenter.new(:irrelevant, demographic_data)

      expect(presenter.labels).to eq "[\"Asian\",\"White\",\"Middle Eastern\"]"
    end
  end

  describe '#values' do
    it "formats values into a JSON Array String" do
      demographic_data = double
      sample_values = [33.33, 50.0, 16.67]
      expect(demographic_data).to receive(:values) { sample_values }

      presenter = GraphPresenter.new(:irrelevant, demographic_data)

      expect(presenter.values).to eq "[33.33,50.0,16.67]"
    end
  end

  describe '#label' do
    it "formats the demographic key as a title" do
      presenter = GraphPresenter.new(:race, {})

      expect(presenter.label).to eq "Race"
    end
  end
end
