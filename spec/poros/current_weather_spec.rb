require 'rails_helper'

RSpec.describe CurrentWeather do
  describe 'instance methods' do
    describe '#initialize' do
      it 'exists and has attributes' do
        data = {
          "last_updated": '2023-06-11 07:00',
          "temp_f": 48.4,
          "condition": {
            "text": 'Partly cloudy',
            "icon": '//cdn.weatherapi.com/weather/64x64/day/116.png'
          },
          "humidity": 90,
          "feelslike_f": 47.3,
          "vis_miles": 9.0,
          "uv": 3.0
        }
        current_weather = CurrentWeather.new(data)

        expect(current_weather).to be_a(CurrentWeather)
        expect(current_weather.last_updated).to eq('2023-06-11 07:00')
        expect(current_weather.temperature).to eq(48.4)
        expect(current_weather.feels_like).to eq(47.3)
        expect(current_weather.humidity).to eq(90)
        expect(current_weather.uvi).to eq(3.0)
        expect(current_weather.visibility).to eq(9.0)
        expect(current_weather.condition).to eq('Partly cloudy')
        expect(current_weather.icon).to eq('cdn.weatherapi.com/weather/64x64/day/116.png')
      end
    end
  end
end
