require 'rails_helper'

RSpec.describe DailyWeather do
  describe 'instance methods' do
    describe '#initialize' do
      it 'exists and has attributes' do
        data = {
          "date": '2023-06-11',
          "day": {
            "maxtemp_f": 68.4,
            "mintemp_f": 53.6,
            "totalsnow_cm": 0.0,
            "condition": {
              "text": 'Heavy rain',
              "icon": '//cdn.weatherapi.com/weather/64x64/day/308.png'
            }
          },
          "astro": {
            "sunrise": '05:32 AM',
            "sunset": '08:28 PM'
          },
          "hour": []
        }
        daily_weather = DailyWeather.new(data)

        expect(daily_weather).to be_a(DailyWeather)
        expect(daily_weather.date).to eq('2023-06-11')
        expect(daily_weather.sunrise).to eq('05:32 AM')
        expect(daily_weather.sunset).to eq('08:28 PM')
        expect(daily_weather.max_temp).to eq(68.4)
        expect(daily_weather.min_temp).to eq(53.6)
        expect(daily_weather.condition).to eq('Heavy rain')
        expect(daily_weather.icon).to eq('cdn.weatherapi.com/weather/64x64/day/308.png')
      end
    end
  end
end
