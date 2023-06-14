class MapService
  def get_coordinates(location)
    get_url("/geocoding/v1/address?location=#{location}")
  end

  def get_travel_data(start_city, end_city)
    get_url("/directions/v2/route?from=#{start_city}&to=#{end_city}")
  end

  private

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: 'http://www.mapquestapi.com') do |f|
      f.params['key'] = ENV['MAPQUEST_API_KEY']
    end
  end
end
