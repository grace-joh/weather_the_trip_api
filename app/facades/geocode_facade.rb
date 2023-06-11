class GeocodeFacade
  def get_coordinates(city_state)
    format_data(coordinate_data(city_state))
  end

  private

  def format_data(data)
    { lat: data[:results][0][:locations][0][:displayLatLng][:lat],
      lon: data[:results][0][:locations][0][:displayLatLng][:lng] }
  end

  def coordinate_data(city_state)
    @_coordinate_data ||= service.get_coordinates(city_state)
  end

  def service
    @_service ||= GeocodeService.new
  end
end
