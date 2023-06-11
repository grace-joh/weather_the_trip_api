class GeocodeFacade
  def get_coordinates(location)
    format_data(coordinates(location))
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
    @_service ||= GeocodeService.new
  end
end
