class MapFacade
  def get_coordinates(location)
    format_data(coordinates(location))
  end

  def get_travel_time(start_city, end_city)
    service.get_travel_data(start_city, end_city)[:route][:formattedTime]
  end

  private

  # returns coordinates in format: "lat,lon"
  def format_data(data)
    "#{data[:results][0][:locations][0][:displayLatLng][:lat]},#{data[:results][0][:locations][0][:displayLatLng][:lng]}"
  end

  def coordinates(location)
    @_coordinate_data ||= service.get_coordinates(location)
  end

  def service
    @_service ||= MapService.new
  end
end
