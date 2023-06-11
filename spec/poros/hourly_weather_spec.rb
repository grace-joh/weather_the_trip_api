require 'rails_helper'

RSpec.describe HourlyWeather do
  describe 'instance methods' do
    describe '#initialize' do
      it 'exists and has attributes' do
        data = {
          "time": '2023-06-11 00:00',
          "temp_f": 55.9,
          "condition": {
            "text": 'Patchy rain possible',
            "icon": '//cdn.weatherapi.com/weather/64x64/night/176.png'
          }
        }
        first_hour_weather = HourlyWeather.new(data)

        expect(first_hour_weather).to be_an(HourlyWeather)
        expect(first_hour_weather.time).to eq('00:00')
        expect(first_hour_weather.temperature).to eq(55.9)
        expect(first_hour_weather.conditions).to eq('Patchy rain possible')
        expect(first_hour_weather.icon).to eq('cdn.weatherapi.com/weather/64x64/night/176.png')
      end
    end
  end
end
