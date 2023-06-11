require 'rails_helper'

RSpec.describe WeatherService, :vcr do
  describe 'instance methods' do
    describe '#get_forecast' do
      before(:each) do
        lat = 39.74001
        lon = 104.99202
        @service = WeatherService.new
        @forecast = @service.get_forecast(lat, lon)
      end

      it 'returns the current weather for a location' do
        expect(@forecast).to be_a(Hash)
        expect(@forecast).to have_key :current
        expect(@forecast[:current]).to have_key :last_updated
        expect(@forecast[:current][:last_updated]).to be_a(String)
        expect(@forecast[:current]).to have_key :temp_f
        expect(@forecast[:current][:temp_f]).to be_a(Float)
        expect(@forecast[:current]).to have_key :feelslike_f
        expect(@forecast[:current][:feelslike_f]).to be_a(Float)
        expect(@forecast[:current]).to have_key :humidity
        expect(@forecast[:current][:humidity]).to be_an(Integer).or be_a(Float)
        expect(@forecast[:current]).to have_key :uv
        expect(@forecast[:current][:uv]).to be_an(Integer).or be_a(Float)
        expect(@forecast[:current]).to have_key :vis_miles
        expect(@forecast[:current][:vis_miles]).to be_an(Integer).or be_a(Float)
        expect(@forecast[:current][:condition]).to have_key :text
        expect(@forecast[:current][:condition][:text]).to be_a(String)
        expect(@forecast[:current][:condition]).to have_key :icon
        expect(@forecast[:current][:condition][:icon]).to be_a(String)
      end

      it 'returns the forecast for a location for the next 5 days' do
        expect(@forecast).to have_key :forecast
        expect(@forecast[:forecast]).to be_a(Hash)
        expect(@forecast[:forecast]).to have_key :forecastday
        expect(@forecast[:forecast][:forecastday]).to be_an(Array)
        expect(@forecast[:forecast][:forecastday].count).to eq(6)

        fifth_day = @forecast[:forecast][:forecastday][5]
        expect(fifth_day).to have_key :date
        expect(fifth_day[:date]).to be_a(String)

        expect(fifth_day).to have_key :day
        expect(fifth_day[:day]).to be_a(Hash)
        expect(fifth_day[:day]).to have_key :maxtemp_f
        expect(fifth_day[:day][:maxtemp_f]).to be_a(Float)
        expect(fifth_day[:day]).to have_key :mintemp_f
        expect(fifth_day[:day][:mintemp_f]).to be_a(Float)
        expect(fifth_day[:day]).to have_key :condition
        expect(fifth_day[:day][:condition]).to be_a(Hash)
        expect(fifth_day[:day][:condition]).to have_key :text
        expect(fifth_day[:day][:condition][:text]).to be_a(String)
        expect(fifth_day[:day][:condition]).to have_key :icon
        expect(fifth_day[:day][:condition][:icon]).to be_a(String)

        expect(fifth_day).to have_key :astro
        expect(fifth_day[:astro]).to be_a(Hash)
        expect(fifth_day[:astro]).to have_key :sunrise
        expect(fifth_day[:astro][:sunrise]).to be_a(String)
        expect(fifth_day[:astro]).to have_key :sunset
        expect(fifth_day[:astro][:sunset]).to be_a(String)
      end

      it 'returns the hourly weather for a location' do
        current_day = @forecast[:forecast][:forecastday][0]
        expect(current_day).to have_key :hour
        expect(current_day[:hour]).to be_an(Array)
        expect(current_day[:hour].count).to eq(24)

        first_hour = current_day[:hour][0]
        expect(first_hour).to have_key :time
        expect(first_hour[:time]).to be_a(String)
        expect(first_hour).to have_key :temp_f
        expect(first_hour[:temp_f]).to be_a(Float)
        expect(first_hour).to have_key :condition
        expect(first_hour[:condition]).to be_a(Hash)
        expect(first_hour[:condition]).to have_key :text
        expect(first_hour[:condition][:text]).to be_a(String)
        expect(first_hour[:condition]).to have_key :icon
        expect(first_hour[:condition][:icon]).to be_a(String)
      end
    end
  end
end
