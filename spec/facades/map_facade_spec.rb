require 'rails_helper'

RSpec.describe MapFacade, :vcr do
  describe 'instance methods' do
    describe '#get_coordinates' do
      it 'returns coordinates for a city state' do
        city_state = 'denver,co'
        coordinates = MapFacade.new.get_coordinates(city_state)

        expect(coordinates).to be_a(String)
        expect(coordinates).to eq('39.74001,-104.99202')
      end
    end
  end
end
