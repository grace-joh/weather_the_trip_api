class Forecast
  attr_reader :current_weather, :daily_weather, :hourly_weather

  def initialize(current_weather, five_day_weather, hourly_weather)
    @current_weather = current_weather
    @daily_weather = five_day_weather
    @hourly_weather = hourly_weather
  end
end
