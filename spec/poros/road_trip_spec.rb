require 'rails_helper'

RSpec.describe RoadTrip do
  describe '#initialize' do
    it 'exists and has attributes' do
      start_city = 'Cincinatti,OH'
      end_city = 'Chicago,IL'
      travel_time = '04:20:37'
      weather_at_eta = {datetime: '2021-03-07 21:00:00 -0700', temperature: 50.0, conditions: 'clear sky'}
      road_trip = RoadTrip.new(start_city, end_city, travel_time, weather_at_eta)

      expect(road_trip).to be_a(RoadTrip)
      expect(road_trip.start_city).to eq(start_city)
      expect(road_trip.end_city).to eq(end_city)
      expect(road_trip.travel_time).to eq(travel_time)
      expect(road_trip.weather_at_eta).to eq(weather_at_eta)
      expect(road_trip.weather_at_eta).to be_a(Hash)
      expect(road_trip.weather_at_eta).to have_key :datetime
      expect(road_trip.weather_at_eta[:datetime]).to be_a(String)
      expect(road_trip.weather_at_eta).to have_key :temperature
      expect(road_trip.weather_at_eta[:temperature]).to be_a(Float)
      expect(road_trip.weather_at_eta).to have_key :conditions
      expect(road_trip.weather_at_eta[:conditions]).to be_a(String)
    end
  end
end
