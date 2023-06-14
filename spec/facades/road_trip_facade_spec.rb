require 'rails_helper'

RSpec.describe RoadTripFacade do
  describe 'instance methods' do
    before(:each) do
      @road_trip_facade = RoadTripFacade.new('Cincinatti,OH', 'Chicago,IL')
    end

    describe '#initialize' do
      it 'exists' do
        expect(@road_trip_facade).to be_a(RoadTripFacade)
      end
    end

    describe '#get_road_trip', :vcr do
      it 'returns a road trip object' do
        road_trip = @road_trip_facade.get_road_trip

        expect(road_trip).to be_a(RoadTrip)
        expect(road_trip.start_city).to eq('Cincinatti,OH')
        expect(road_trip.end_city).to eq('Chicago,IL')
        expect(road_trip.travel_time).to be_a(String)
        expect(road_trip.travel_time).to eq('04:20:37')
        expect(road_trip.weather_at_eta).to be_a(DestinationWeather)
        expect(road_trip.weather_at_eta.datetime).to be_a(String)
        expect(road_trip.weather_at_eta.temperature).to be_a(Float)
        expect(road_trip.weather_at_eta.conditions).to be_a(String)
      end

      it 'returns impossible route if no route exists' do
        road_trip_facade = RoadTripFacade.new('Cincinatti,OH', 'South Korea')
        road_trip = road_trip_facade.get_road_trip

        expect(road_trip).to be_a(RoadTrip)
        expect(road_trip.start_city).to eq('Cincinatti,OH')
        expect(road_trip.end_city).to eq('South Korea')
        expect(road_trip.travel_time).to be_a(String)
        expect(road_trip.travel_time).to eq('impossible route')
        expect(road_trip.weather_at_eta).to be_a(Hash)
        expect(road_trip.weather_at_eta).to be_empty
      end
    end
  end
end
