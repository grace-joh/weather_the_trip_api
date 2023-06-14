require 'rails_helper'

RSpec.describe ForecastFacade do
  describe 'instance methods' do
    before(:each) do
      location = 'denver,co'
      @facade = ForecastFacade.new(location)
    end

    describe '#initialize' do
      it 'exists' do
        expect(@facade).to be_a(ForecastFacade)
      end
    end

    describe '#get_forecast', :vcr do
      it 'returns a forecast object' do
        denver_forecast = @facade.get_forecast
        expect(denver_forecast).to be_a(Forecast)

        expect(denver_forecast.current_weather).to be_a(CurrentWeather)
        expect(denver_forecast.daily_weather).to be_an(Array)
        expect(denver_forecast.daily_weather.count).to eq(5)
        expect(denver_forecast.daily_weather).to all(be_a(DailyWeather))
        expect(denver_forecast.hourly_weather).to be_an(Array)
        expect(denver_forecast.hourly_weather.count).to eq(24)
        expect(denver_forecast.hourly_weather).to all(be_an(HourlyWeather))
      end
    end

    describe '#get_destination_weather', :vcr do
      it 'returns a destination weather object' do
        date = DateTime.now.strftime('%Y-%m-%d')
        hour = DateTime.now.strftime('%H')
        destination_weather = @facade.get_destination_weather(date, hour)

        expect(destination_weather).to be_a(DestinationWeather)
        expect(destination_weather.datetime).to be_a(String)
        expect(destination_weather.datetime).to eq("#{date} #{hour}:00")
        expect(destination_weather.temperature).to be_a(Float)
        expect(destination_weather.conditions).to be_a(String)
      end
    end
  end
end
