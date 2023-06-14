class RoadTripFacade
  def initialize(origin, destination)
    @start_city = origin
    @end_city = destination
  end

  def get_road_trip
    return RoadTrip.new(@start_city, @end_city, 'impossible route', {}) if travel_time == 'impossible route'

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
    # add the travel time to the current time at the destination
    (current_destination_time + time[0].hours + time[1].minutes).localtime
  end

  def current_destination_time
    end_coord = map_facade.get_coordinates(@end_city)
    # find the timezone of the destination
    destination_timezone = Timezone.lookup(end_coord[0], end_coord[1]).name
    # find the current time in the destination
    Time.now.utc.in_time_zone(destination_timezone)
  end

  def travel_time
    map_facade.get_travel_time(@start_city, @end_city)
  end

  def map_facade
    @_map_facade ||= MapFacade.new
  end
end
