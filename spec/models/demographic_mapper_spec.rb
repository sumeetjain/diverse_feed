require 'rails_helper'

RSpec.describe DemographicMapper, type: :model do
  context 'for User #1' do
    it 'has race breakdown' do
      mapper = DemographicMapper.new

      expect(mapper.race).to include({
        white: 50.0,
        black: 25.0,
        indian: 25.0
      })
    end
  end
end
