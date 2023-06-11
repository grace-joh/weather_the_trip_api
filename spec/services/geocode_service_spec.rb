require 'rails_helper'

RSpec.describe GeocodeService do
  describe 'instance methods' do
    before :each do
      @service = GeocodeService.new
    end

    it 'returns lat and long for a given city' do
      expected = { lat: 39.74001, lon: -104.99202 }
      city_state = 'denver,co'
      data = @service.get_coordinates(city_state)

      expect(data).to be_a(Hash)
      expect(data).to have_key(:results)
      expect(data[:results]).to be_an(Array)

      location = data[:results][0]

      expect(location).to have_key(:providedLocation)
      expect(location[:providedLocation]).to be_a(Hash)
      expect(location[:providedLocation]).to have_key(:location)
      expect(location[:providedLocation][:location].downcase).to eq(city_state)

      expect(location).to have_key(:locations)
      expect(location[:locations]).to be_an(Array)
      expect(location[:locations][0]).to be_a(Hash)
      expect(location[:locations][0]).to have_key(:displayLatLng)
      expect(location[:locations][0][:displayLatLng]).to be_a(Hash)
      expect(location[:locations][0][:displayLatLng]).to have_key(:lat)
      expect(location[:locations][0][:displayLatLng][:lat]).to be_a(Float)
      expect(location[:locations][0][:displayLatLng][:lat]).to eq(expected[:lat])
      expect(location[:locations][0][:displayLatLng]).to have_key(:lng)
      expect(location[:locations][0][:displayLatLng][:lng]).to eq(expected[:lon])
    end
  end
end
