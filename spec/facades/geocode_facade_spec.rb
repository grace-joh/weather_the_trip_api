require 'rails_helper'

RSpec.describe GeocodeFacade, :vcr do
  describe 'instance methods' do
    it 'get_coordinates(address)' do
      city_state = 'denver,co'
      coordinates = GeocodeFacade.new.get_coordinates(city_state)

      expect(coordinates).to be_a(Hash)

      expect(coordinates).to have_key(:lat)
      expect(coordinates[:lat]).to be_a(Float)
      expect(coordinates[:lat]).to eq(39.74001)
      expect(coordinates).to have_key(:lon)
      expect(coordinates[:lon]).to eq(-104.99202)
    end
  end
end
