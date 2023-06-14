require 'rails_helper'

RSpec.describe 'Road Trip Creation', :vcr do
  describe 'happy path' do
    it 'creates a road trip' do
      user = User.create!(email: "whatever@example.com", password: "password", password_confirmation: "password")

      params = {
        "origin": "Cincinatti,OH",
        "destination": "Chicago,IL",
        "api_key": user.api_key
      }
      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v0/road_trip', headers: headers, params: JSON.generate(params)

      expect(response).to be_successful
      expect(response.status).to eq(201)

      road_trip = JSON.parse(response.body, symbolize_names: true)

      expect(road_trip).to be_a(Hash)
      expect(road_trip).to have_key :data
      road_trip_data = road_trip[:data]
      expect(road_trip_data).to be_a(Hash)
      expect(road_trip_data).to have_key :id
      expect(road_trip_data[:id]).to eq(nil)
      expect(road_trip_data).to have_key :type
      expect(road_trip_data[:type]).to eq('road_trip')
      expect(road_trip_data).to have_key :attributes
      attributes = road_trip_data[:attributes]
      expect(attributes).to be_a(Hash)
      expect(attributes).to have_key :start_city
      expect(attributes[:start_city]).to be_a(String)
      expect(attributes).to have_key :end_city
      expect(attributes[:end_city]).to be_a(String)
      expect(attributes).to have_key :travel_time
      expect(attributes[:travel_time]).to be_a(String)
      expect(attributes).to have_key :weather_at_eta
      weather = attributes[:weather_at_eta]
      expect(weather).to be_a(Hash)
      expect(weather).to have_key :datetime
      expect(weather[:datetime]).to be_a(String)
      expect(weather).to have_key :temperature
      expect(weather[:temperature]).to be_a(Float)
      expect(weather).to have_key :conditions
      expect(weather[:conditions]).to be_a(String)
    end

    xit 'returns impossible travel time if no route exists' do
    end
  end

  describe 'sad path' do
    it 'returns an error if api key is invalid' do
      User.create!(email: "whatever@example.com", password: "password", password_confirmation: "password")

      params = {
        "origin": "Cincinatti,OH",
        "destination": "Chicago,IL",
        "api_key": 'invalid_api_key'
      }

      post '/api/v0/road_trip', params: JSON.generate(params)

      expect(response).to_not be_successful
      expect(response.status).to eq(401)

      error = JSON.parse(response.body, symbolize_names: true)

      expect(error).to be_a(Hash)
      expect(error).to have_key :error
      expect(error[:error]).to eq('Unauthorized')
    end
  end
end
