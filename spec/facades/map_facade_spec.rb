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

    describe '#get_travel_time' do
      it 'returns travel time for a start city and end city' do
        start_city = 'Cincinatti,OH'
        end_city = 'Chicago,IL'
        travel_time = MapFacade.new.get_travel_time(start_city, end_city)

        expect(travel_time).to be_a(String)
        expect(travel_time).to eq('04:20:37')
      end
    end
  end
end
