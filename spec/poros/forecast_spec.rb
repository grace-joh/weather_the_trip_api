require 'rails_helper'

RSpec.describe Forecast do
  describe 'instance methods' do
    describe '#initialize' do
      it 'exists and has attributes' do
        forecast_test_data
        five_day_weather = [@daily_weather, @daily_weather, @daily_weather]
        three_hours = [@hourly_weather, @hourly_weather, @hourly_weather]
        forecast = Forecast.new(@current_weather, five_day_weather, three_hours)

        expect(forecast).to be_a(Forecast)
        expect(forecast.current_weather).to be_a(CurrentWeather)
        expect(forecast.daily_weather).to be_an(Array)
        expect(forecast.daily_weather.count).to eq(3)
        expect(forecast.daily_weather).to all(be_a(DailyWeather))
        expect(forecast.hourly_weather).to be_an(Array)
        expect(forecast.hourly_weather.count).to eq(3)
        expect(forecast.hourly_weather).to all(be_an(HourlyWeather))
      end
    end
  end
end
