class WeatherService
  def get_forecast(lat_lon)
    get_url("forecast.json?q=#{lat_lon}&days=6")
  end

  private

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: 'http://api.weatherapi.com/v1/') do |faraday|
      faraday.params['key'] = ENV['WEATHER_API_KEY']
    end
  end
end
