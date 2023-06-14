class RoadTripFacade
  def initialize(origin, destination)
    @start_city = origin
    @end_city = destination
  end

  def get_road_trip
    RoadTrip.new(@start_city, @end_city, travel_time, weather_at_eta)
  end

  private

  def weather_at_eta
    forecast_facade.get_destination_weather(date, hour)
  end

  def forecast_facade
    @_forecast_facade ||= ForecastFacade.new(@end_city)
  end

  def date
    arrival_datetime.strftime('%Y-%m-%d')
  end

  def hour
    arrival_datetime.strftime('%H')
  end

  def arrival_datetime
    time = travel_time.split(':').map(&:to_i)
    DateTime.now + time[0].hours + time[1].minutes
  end

  def travel_time
    map_facade.get_travel_time(@start_city, @end_city)
  end

  def map_facade
    @_map_facade ||= MapFacade.new
  end
end
