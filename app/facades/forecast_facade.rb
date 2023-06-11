class ForecastFacade
  def initialize(city, state)
    @city_state = "#{city},#{state}"
  end

  def get_forecast
    Forecast.new(current_weather, five_day_weather, hourly_weather)
  end

  private

  def current_weather
    current_weather_data = forecast_data[:current]
    CurrentWeather.new(current_weather_data)
  end

  def five_day_weather
    five_day_weather_data = forecast_data[:forecast][:forecastday][1..5]
    five_day_weather_data.map do |day|
      DailyWeather.new(day)
    end
  end

  def hourly_weather
    hourly_weather_data = forecast_data[:forecast][:forecastday][0][:hour]
    hourly_weather_data.map do |hour|
      HourlyWeather.new(hour)
    end
  end

  def forecast_data
    lat, lon = coordinates
    weather_service.get_forecast(lat, lon)
  end

  def coordinates
    @_coordinates ||= geocode_facade.get_coordinates(@city_state)
    return @_coordinates[:lat], @_coordinates[:lon]
  end

  def weather_service
    @_weather_service ||= WeatherService.new
  end

  def geocode_facade
    @_geocode_facade ||= GeocodeFacade.new
  end
end
