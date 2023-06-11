require 'rails_helper'

RSpec.describe 'Forecast API' do
  describe 'Get Weather Forecast for a City' do
    describe 'happy path', :vcr do
      before(:each) do
        get '/api/v0/forecast?location=denver,co'

        expect(response).to be_successful
        expect(response.status).to eq(200)

        @denver_weather = JSON.parse(response.body, symbolize_names: true)
      end

      it 'returns weather data for a city' do
        expect(@denver_weather).to be_a Hash
        expect(@denver_weather).to have_key :data
        expect(@denver_weather[:data]).to be_a Hash
        expect(@denver_weather[:data]).to have_key :id
        expect(@denver_weather[:data][:id]).to eq(nil)
        expect(@denver_weather[:data]).to have_key :type
        expect(@denver_weather[:data][:type]).to eq('forecast')

        expect(@denver_weather[:data]).to have_key :attributes
        attributes = @denver_weather[:data][:attributes]
        expect(attributes).to be_a Hash

        expect(attributes).to have_key :current_weather
        current = attributes[:current_weather]
        expect(current).to be_a Hash
        expect(current).to have_key :last_updated
        expect(current[:last_updated]).to be_a String
        expect(current).to have_key :temperature
        expect(current[:temperature]).to be_a Float
        expect(current).to have_key :feels_like
        expect(current[:feels_like]).to be_a Float
        expect(current).to have_key :humidity
        expect(current[:humidity]).to be_a Integer
        expect(current).to have_key :uvi
        expect(current[:uvi]).to be_a Float
        expect(current).to have_key :visibility
        expect(current[:visibility]).to be_a Float
        expect(current).to have_key :condition
        expect(current[:condition]).to be_a String
        expect(current).to have_key :icon
        expect(current[:icon]).to be_a String

        expect(attributes).to have_key :daily_weather
        daily = attributes[:daily_weather]
        expect(daily).to be_an Array
        expect(daily.count).to eq(5)
        daily.each do |day|
          expect(day).to be_a Hash
          expect(day).to have_key :date
          expect(day[:date]).to be_a String
          expect(day).to have_key :sunrise
          expect(day[:sunrise]).to be_a String
          expect(day).to have_key :sunset
          expect(day[:sunset]).to be_a String
          expect(day).to have_key :max_temp
          expect(day[:max_temp]).to be_a Float
          expect(day).to have_key :min_temp
          expect(day[:min_temp]).to be_a Float
          expect(day).to have_key :condition
          expect(day[:condition]).to be_a String
          expect(day).to have_key :icon
          expect(day[:icon]).to be_a String
        end

        expect(attributes).to have_key :hourly_weather
        hourly = attributes[:hourly_weather]
        expect(hourly).to be_an Array
        expect(hourly.count).to eq(24)
        hourly.each do |hour|
          expect(hour).to be_a Hash
          expect(hour).to have_key :time
          expect(hour[:time]).to be_a String
          expect(hour).to have_key :temperature
          expect(hour[:temperature]).to be_a Float
          expect(hour).to have_key :conditions
          expect(hour[:conditions]).to be_a String
          expect(hour).to have_key :icon
          expect(hour[:icon]).to be_a String
        end
      end

      it 'does not send data not required by the json contract' do
        attributes = @denver_weather[:data][:attributes]
        expect(attributes).to_not have_key :name
        expect(attributes).to_not have_key :region
        expect(attributes).to_not have_key :country
        expect(attributes).to_not have_key :lat
        expect(attributes).to_not have_key :lon
        expect(attributes).to_not have_key :tz_id
        expect(attributes).to_not have_key :localtime_epoch
        expect(attributes).to_not have_key :localtime
        expect(attributes).to_not have_key :alerts
        current = attributes[:current_weather]
        expect(current).to_not have_key :last_updated_epoch
        expect(current).to_not have_key :temp_c
        expect(current).to_not have_key :is_day
        expect(current).to_not have_key :code
        expect(current).to_not have_key :wind_mph
        expect(current).to_not have_key :wind_kph
        expect(current).to_not have_key :wind_degree
        expect(current).to_not have_key :wind_dir
        expect(current).to_not have_key :pressure_mb
        expect(current).to_not have_key :pressure_in
        expect(current).to_not have_key :precip_mm
        expect(current).to_not have_key :precip_in
        expect(current).to_not have_key :cloud
        expect(current).to_not have_key :feelslike_c
        expect(current).to_not have_key :vis_km
        expect(current).to_not have_key :gust_mph
        expect(current).to_not have_key :gust_kph
        expect(current).to_not have_key :air_quality
        first_day = attributes[:daily_weather][0]
        expect(first_day).to_not have_key :date_epoch
        expect(first_day).to_not have_key :maxtemp_c
        expect(first_day).to_not have_key :mintemp_c
        expect(first_day).to_not have_key :avgtemp_c
        expect(first_day).to_not have_key :avgtemp_f
        expect(first_day).to_not have_key :maxwind_mph
        expect(first_day).to_not have_key :maxwind_kph
        expect(first_day).to_not have_key :totalprecip_mm
        expect(first_day).to_not have_key :totalprecip_in
        expect(first_day).to_not have_key :avgvis_km
        expect(first_day).to_not have_key :avgvis_miles
        expect(first_day).to_not have_key :avghumidity
        expect(first_day).to_not have_key :daily_will_it_rain
        expect(first_day).to_not have_key :daily_chance_of_rain
        expect(first_day).to_not have_key :daily_will_it_snow
        expect(first_day).to_not have_key :daily_chance_of_snow
        expect(first_day).to_not have_key :code
        expect(first_day).to_not have_key :uv
        expect(first_day).to_not have_key :astro
        expect(first_day).to_not have_key :moonrise
        expect(first_day).to_not have_key :moonset
        expect(first_day).to_not have_key :moon_phase
        expect(first_day).to_not have_key :moon_illumination
        first_hour = attributes[:hourly_weather][0]
        expect(first_hour).to_not have_key :time_epoch
        expect(first_hour).to_not have_key :temp_c
        expect(first_hour).to_not have_key :is_day
        expect(first_hour).to_not have_key :code
        expect(first_hour).to_not have_key :wind_mph
        expect(first_hour).to_not have_key :wind_kph
        expect(first_hour).to_not have_key :wind_degree
        expect(first_hour).to_not have_key :wind_dir
        expect(first_hour).to_not have_key :pressure_mb
        expect(first_hour).to_not have_key :pressure_in
        expect(first_hour).to_not have_key :precip_mm
        expect(first_hour).to_not have_key :precip_in
        expect(first_hour).to_not have_key :humidity
        expect(first_hour).to_not have_key :cloud
        expect(first_hour).to_not have_key :feelslike_c
        expect(first_hour).to_not have_key :feelslike_f
        expect(first_hour).to_not have_key :windchill_c
        expect(first_hour).to_not have_key :windchill_f
        expect(first_hour).to_not have_key :heatindex_c
        expect(first_hour).to_not have_key :heatindex_f
        expect(first_hour).to_not have_key :dewpoint_c
        expect(first_hour).to_not have_key :dewpoint_f
        expect(first_hour).to_not have_key :will_it_rain
        expect(first_hour).to_not have_key :chance_of_rain
        expect(first_hour).to_not have_key :will_it_snow
        expect(first_hour).to_not have_key :chance_of_snow
        expect(first_hour).to_not have_key :vis_km
        expect(first_hour).to_not have_key :vis_miles
        expect(first_hour).to_not have_key :gust_mph
        expect(first_hour).to_not have_key :gust_kph
        expect(first_hour).to_not have_key :uv
      end
    end
  end
end
