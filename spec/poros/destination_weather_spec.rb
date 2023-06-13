require 'rails_helper'

RSpec.describe DestinationWeather do
  describe '#initialize' do
    it 'exists and has attributes' do
      datetime = "2023-04-07 23:00"
      temperature = 44.2
      condition = 'Cloudy with a chance of meatballs'
      destination_weather = DestinationWeather.new(datetime, temperature, condition)

      expect(destination_weather).to be_a(DestinationWeather)
      expect(destination_weather.datetime).to eq(datetime)
      expect(destination_weather.temperature).to eq(temperature)
      expect(destination_weather.conditions).to eq(condition)
    end
  end
end
