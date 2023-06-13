class ForecastFacade
  def initialize(location)
    @location = location
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
    @_forecast_data ||= weather_service.get_forecast(coordinates)
  end

  def weather_service
    @_weather_service ||= WeatherService.new
  end

  def coordinates
    @_coordinates ||= map_facade.get_coordinates(@location)
  end

  def map_facade
    @_map_facade ||= MapFacade.new
  end
end
